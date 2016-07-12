
module QrcodeGenerator

  class Runner

    attr_reader :workspace

    def initialize(workspace)
      @workspace = workspace
    end

    def run
      puts "Runner run... #{workspace}"
    end

  end

end