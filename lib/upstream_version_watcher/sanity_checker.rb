require 'tmpdir'
require 'open-uri'
require 'pry'

module UpstreamVersionWatcher
  class SanityChecker
    attr :errors

    def initialize args={}
      @errors               = Array.new
      @upstream_config_args = args["upstream_config_args"]
    end

    def check_buildpack_dependencies
      upstream_config.buildpacks.each do |buildpack|
        manifest_data = get_manifest_for(buildpack)
        manifest      = YAML.load(manifest_data)
        manifest['dependencies'].map {|dependency|
          dependency['name']
        }.each do |dependency_name|
          unless buildpack.dependencies.keys.include?(dependency_name)
            errors << "upstream.yml contains no info for #{buildpack.name}: #{dependency_name}"
          end
        end
      end
    end

    private

    def upstream_config
      @upstream ||= UpstreamConfig.new(@upstream_config_args)
    end

    def get_manifest_for(buildpack)
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
