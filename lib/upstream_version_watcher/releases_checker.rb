require 'tmpdir'
require 'open-uri'

module UpstreamVersionWatcher
  class ReleasesChecker
    attr :updates

    def initialize(args = {})
      @updates         = Array.new
      @upstream_config = UpstreamConfig.new(args)
    end

    def check_for_updates
      @upstream_config.buildpacks.each do |buildpack_name, buildpack_data|


      end

      upstream_config.buildpacks.each do |buildpack_name, buildpack_data|
        manifest_data = get_manifest_for(buildpack_data)
        manifest      = YAML.load(manifest_data)
        manifest["dependencies"].map do |dependency|
          dependency["name"]
        end.uniq.each do |dependency|
          unless buildpack_data.dependencies.keys.include?(dependency)
            errors << "upstream.yml contains no info for #{buildpack_name}: #{dependency}"
          end
        end
      end
    end
  end
end
