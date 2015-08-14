require 'spec_helper'

module UpstreamVersionWatcher
  describe ReleasesChecker do

    let(:repo_name) { 'hot_sauce_repo' }
    let(:repo_path) { create_git_repo(repo_name) }
    let(:checker)   { ReleasesChecker.new('upstream_config_args' => options) }
    let(:options) do
      {
        'buildpacks' => [
          'foo-buildpack' => {
            'dependencies' => {
              'foo-compiler' => { 'scm-tag' => "file://#{repo_path}" }
            }
          }
        ]
      }
    end

    before do
      create_git_tag(repo_path, tag_name: 'v1.0')
    end

    it "knows when there are new releases" do
      checker.check_for_updates
      expect(checker.updates.length).to eq 1
    end
  end
end
