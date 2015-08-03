require 'spec_helper'

describe UpstreamVersionWatcher::SanityChecker do
  SanityChecker = UpstreamVersionWatcher::SanityChecker

  describe "missing dependency" do
    it "emits errors for each missing dependency" do
      Dir.mktmpdir do |dir|
        Dir.chdir dir do
          data = {
            "buildpack" => {
              "foo-buildpack" => {
                "url" => "file://#{File.dirname(File.dirname(__FILE__))}/fixtures/foo-buildpack"
              }
            }
          }

          checker = SanityChecker.new("upstream_config_args" => data)
          checker.check
          expect(checker.errors.length).to eq 2
        end
      end
    end
  end
end
