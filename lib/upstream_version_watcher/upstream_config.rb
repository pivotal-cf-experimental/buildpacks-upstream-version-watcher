require 'yaml'

module UpstreamVersionWatcher
  class UpstreamConfig
    DEFAULT_FILENAME = "upstream.yml"

    attr_reader :data

    def initialize(thing=nil)
      @data = if thing.is_a?(Hash)
                thing
              elsif thing.is_a?(String)
                YAML.load_file thing
              elsif thing.nil?
                YAML.load_file DEFAULT_FILENAME
              end
    end

    def buildpacks
      @buildpacks ||= @data["buildpacks"].map do |buildpack_data|
        Buildpack.new(buildpack_data)
      end
    end
  end
end
