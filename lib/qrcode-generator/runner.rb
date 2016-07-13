
require 'fileutils'
require 'rmagick'
require 'rqrcode'

module QrcodeGenerator

  class Runner

    attr_reader :workspace, :options, :destSpace

    def initialize(workspace, options)
      @workspace = workspace
      @options = options

      time = Time.now

      dayStr = time.strftime('%m-%d')
      clockStr = time.strftime('%H:%M:%S')
      @destSpace = File.join(workspace, "qrcode #{dayStr} #{clockStr}")
    end

    def run
      txtPath = File.join(workspace, "links.txt")
      if !File.file?(txtPath)
        puts "ERROR: Could not find file 'links.txt' in current directory"
        return
      end

      FileUtils.mkdir(destSpace) if !File.directory?(destSpace)

      File.readlines(txtPath).each do |line|
        line = line.strip.chomp
        next if line.empty?

        if reverse_point = line.reverse.index(/[ ,]/)
          point = line.length - reverse_point
          link = line[point..-1]
          title = line[0, point].strip.chomp(",").strip
          title = link if title.empty?
        else
          link = line
          title = link
        end

        filename = sanitize_filename(title) + ".png"

        to_qrcode_file(link, filename)
      end
    end

    def sanitize_filename(basename)

      basename.strip.gsub(/[\:\*\"\<\>\|]/, '').gsub(/[\\\/\.\?]/, '_')
    end

    def to_qrcode_file(url,filename)
      
      img = draw_qrcode_image(url, options[:width])

      img.format = "PNG"

      img.write(File.join(destSpace, filename))
    end

    def draw_qrcode_image(url, width)
      qr_width = 17 + 4 * options[:size] + 2 * options[:border]
      width = width < qr_width ? qr_width : width
      img = Magick::Image.new(qr_width,qr_width)
      build_qrcode(url).draw(img)
      img = img.resize(width,width,Magick::PointFilter)

      if options[:logo]
        logo_size = width/(options[:logo_denominator]*1.0)
        build_logo(img, logo_size)
      end

      img
    end

    def build_qrcode(url)
      qr = RQRCode::QRCode.new(url, size: options[:size], level: options[:level])
      border = options[:border]
      qrcode = Magick::Draw.new
      qr.modules.each_index do |x|
        qr.modules.each_index do |y|
          qrcode.fill( qr.dark?(x,y) ? 'black' : 'white' )
          qrcode.point(y+border,x+border)
        end
      end
      qrcode
    end

    def build_logo(img,size)
      logo_filepath = File.join(workspace, "logo.png")

      if File.exist?(logo_filepath)
        logo = Magick::Image.read(logo_filepath)[0]
        logo = logo.resize(size,size)

        img.composite!(logo, Magick::CenterGravity, Magick::OverCompositeOp)
      end
      
      img
    end

    def to_qrcode_blob(url,width)

      img = draw_qrcode_image(url, width)

      blob = img.to_blob {
        self.format = 'PNG'
      }
      blob
    end

    def to_qrcode_base64(blob)
      "data:image/png;base64,#{Base64.encode64(blob)}"
    end

  end

end