require 'yaml'

module UpstreamVersionWatcher
  class UpstreamConfig
    DEFAULT_FILENAME = "upstream.yml"

    attr_reader :data

    def initialize thing=nil
      @data = if thing.is_a?(Hash)
                thing
              elsif thing.is_a?(String)
                YAML.load_file thing
              else
                YAML.load_file DEFAULT_FILENAME
              end
    end

    def buildpacks
      @buildpacks ||= @data["buildpack"].inject({}) do |hash, bpdata|
        name, data = *bpdata
        hash[name] = Buildpack.new data
        hash
      end
    end
  end
end
