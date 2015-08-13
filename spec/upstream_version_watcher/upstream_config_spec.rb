require 'spec_helper'

module UpstreamVersionWatcher
  describe UpstreamConfig do
    describe ".new" do
      it "loads 'upstream.yml' by default" do
        Dir.mktmpdir do |dir|
          Dir.chdir dir do
            File.open("upstream.yml", "w") { |f| f.write "hello: 1234" }

            expect(UpstreamConfig.new.data["hello"]).to eq 1234

          end
        end
      end

      it "accepts an alternate filename" do
        Dir.mktmpdir do |dir|
          Dir.chdir dir do
            File.open("fezziwig.yml", "w") { |f| f.write "hello: 1234" }

            expect(UpstreamConfig.new("fezziwig.yml").data["hello"]).to eq 1234

          end
        end
      end

      it "accepts injection of test data" do
        Dir.mktmpdir do |dir|
          Dir.chdir dir do
            hash = {"hello" => 1234}

            expect(UpstreamConfig.new(hash).data["hello"]).to eq 1234
          end
        end
      end
    end

    describe "#buildpacks" do
      it "returns hash of Buildpack objects" do
        hash = {
          "buildpack" => {
            "foo" => {"url" => "http://foo.bar"},
            "bar" => {"url" => "http://bar.bar"}
          }
        }

        config = UpstreamConfig.new(hash)
        expect(config.buildpacks.length).to eq 2
        expect(config.buildpacks["foo"].url).to eq ("http://foo.bar")
        expect(config.buildpacks["bar"].url).to eq ("http://bar.bar")
      end
    end
  end
end
