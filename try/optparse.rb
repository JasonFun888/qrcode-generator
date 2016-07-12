require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = %Q{
usage: qrcode-generator <command> [options]

    the commands are:
        init       \tcreate workspace on the current directory
        run        \tstart generator qrcodes

    the options are:
}

  options[:width] = 400
  options[:size] = 4
  options[:level] = :h
  options[:logo] = true
  options[:logo_denominator] = 3

  opts.on("--width=400", "chnage qrcode image width") do |n|
    options[:width] = n.to_i
  end

  opts.on("--size=4", "change qrcode size") do |n|
    options[:size] = n.to_i
  end

  opts.on("--level=h", "change qrcode level, support: l,m,q,h") do |n|
    options[:level] = n.to_sym
  end

  opts.on("--logo=true", "if you don't want logo, set false") do |n|
    options[:logo] = false if n=="false"
  end

  opts.on("--logo_denominator=3", "if set 3, then the logo's width will equal to 1/3 of whole image width") do |n|
    options[:logo_denominator] = n.to_i
  end

end.parse!