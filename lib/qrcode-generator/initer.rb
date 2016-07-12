
module QrcodeGenerator

  class Initer

    attr_reader :workspace

    def initialize(workspace)
      @workspace = workspace
    end

    def init
      puts "Initer init... #{workspace}"
    end

  end

end