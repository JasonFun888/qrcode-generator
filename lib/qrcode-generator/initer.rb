
require 'find'
require 'fileutils'

module QrcodeGenerator

  class Initer

    attr_reader :workspace

    def initialize(workspace)
      @workspace = workspace
    end

    def init
      if !workspace_empty?
        puts "ERROR: Count not init, because current folder is not empty"
        return
      end

      init_workspace
    end

    def workspace_empty?
      total_size = 0

      Find.find(workspace) do |path|
        next if path == workspace or File.basename(path)[0] == ?.
        total_size += 1
      end

      total_size == 0
    end

    #copy files into workspace
    def init_workspace
      source = File.expand_path("../workspace", __dir__)

      FileUtils.cp_r("#{source}/.", workspace)
    end

  end

end