require 'spec_helper'

module UpstreamVersionWatcher
  describe SanityChecker do

    it "emits errors for each missing dependency" do
      data = {
        'buildpacks' => [
          {
            'name' => 'foo-buildpack',
            'url'  => "file://#{File.dirname(File.dirname(__FILE__))}/fixtures/foo-buildpack"
          }
        ]
      }

      checker = SanityChecker.new("upstream_config_args" => data)
      checker.check_buildpack_dependencies
      expect(checker.errors.length).to eq 2
    end
  end
end
