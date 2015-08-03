module UpstreamVersionWatcher
  class SanityChecker
    def check
      check_buildpack_dependencies
    end

    def check_buildpack_dependencies
      upstream_config.buildpacks.each do |buildpack|
        
      end
    end

    private

    def upstream_config
      @upstream ||= UpstreamConfig.new
    end
  end
end
