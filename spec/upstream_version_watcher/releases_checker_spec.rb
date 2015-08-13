require 'spec_helper'

module UpstreamVersionWatcher
  describe ReleasesChecker do

    describe "when checking for releases" do
      let(:checker) { ReleasesChecker.new("upstream_config_args" => options) }
      let(:options) do
        data = {
          "buildpack" => {
            "foo-buildpack" => {
              "dependencies" => {
                "foo-compiler" => { "scm-tag" => "http://github.com/foo-co/compiler" },
                "foo-fighter"  => { "scm-tag" => "https://myinternal/gitserver/foo-fighter.git" }
              }
            }
          }
        }
      end

      it "notifies new releases since the last check" do
        checker.check
        expect(checker.updates.length).to eq 1
      end
    end
  end
end
