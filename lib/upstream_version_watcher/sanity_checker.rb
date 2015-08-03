require 'tmpdir'
require 'open-uri'

module UpstreamVersionWatcher
  class SanityChecker
    attr :errors

    def initialize args={}
      @errors = []
      @upstream_config_args = args["upstream_config_args"]
    end

    def check
      check_buildpack_dependencies
    end

    def check_buildpack_dependencies
      upstream_config.buildpacks.each do |buildpack_name, buildpack_data|
        manifest_data = get_manifest_for buildpack_data
        manifest = YAML.load manifest_data
        manifest["dependencies"].map do |dependency|
          dependency["name"]
        end.uniq.each do |dependency|
          unless buildpack_data.dependencies.keys.include?(dependency)
            errors << "upstream.yml contains no info for #{buildpack_name}: #{dependency}"
          end
        end
      end
    end

    private

    def upstream_config
      @upstream ||= UpstreamConfig.new(@upstream_config_args)
    end

    def get_manifest_for buildpack
      if buildpack.url =~ /^file:/
        `curl -s "#{File.join(buildpack.url, Buildpack::MANIFEST_NAME)}"`
      else
        Dir.mktmpdir do |dir|
          Dir.chdir dir do
            `git clone --depth 1 "#{buildpack.url}" --branch "#{buildpack.branch}"`
            Dir.chdir File.basename(buildpack.url) do
              File.read Buildpack::MANIFEST_NAME
            end
          end
        end
      end
    end
  end
end
