require 'spec_helper'

describe UpstreamVersionWatcher::Buildpack do
  Buildpack = UpstreamVersionWatcher::Buildpack

  describe "initialization and defaults" do
    it "accepts a hash of string keys" do
      expect(Buildpack.new("url" => "https://foo.bar/bazz/quux").url).to eq "https://foo.bar/bazz/quux"
    end

    it "requires 'url'" do
      expect { Buildpack.new({}) }.to raise_error(ArgumentError)
    end

    it "allows 'branch'" do
      expect(Buildpack.new("url" => "https://foo.bar/bazz/quux", "branch" => "develop").branch).to eq "develop"
    end

    it "defaults 'branch' to 'master'" do
      expect(Buildpack.new("url" => "https://foo.bar/bazz/quux").branch).to eq "master"
    end

    it "allows 'dependencies'" do
      expect(Buildpack.new("url" => "asdf", "dependencies" => {
            "foo" => {},
            "bar" => {},
            "bazz" => {}
          }).dependencies).to eq({
            "foo" => {},
            "bar" => {},
            "bazz" => {}
        })
    end
  end
end
