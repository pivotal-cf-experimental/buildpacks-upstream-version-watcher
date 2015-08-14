require 'spec_helper'

module UpstreamVersionWatcher
  describe UpstreamConfig do
    describe ".new" do

      let(:filename)      { nil }
      let(:upstream_info) { 'hello: 1234' }
      let(:project_dir)   { Dir.mktmpdir }

      context 'when upstream.yml is provided' do
        let(:filename) { 'upstream.yml' }
        before do
          File.write("#{project_dir}/#{filename}", upstream_info)
        end

        it 'it\'s loaded by default' do
          Dir.chdir(project_dir) do
            expect(UpstreamConfig.new.data["hello"]).to eq 1234
          end
        end
      end

      context 'when an alternate filename is provided' do
        let(:filename) { 'fezziwig.yml' }
        before do
          File.write("#{project_dir}/#{filename}", upstream_info)
        end

        it 'it\'s loaded when passed as an argument' do
          Dir.chdir(project_dir) do
            expect(UpstreamConfig.new('fezziwig.yml').data["hello"]).to eq 1234
          end
        end
      end

      context 'when hash data is injected' do
        it 'it\'s loaded when passed as an argument' do

          Dir.chdir(project_dir) do
            expect(UpstreamConfig.new({'fake_data' => 1234}).data['fake_data']).to eq 1234
          end
        end
      end
    end

    describe "#buildpacks" do
      it "returns an array of Buildpack objects" do
        hash = {
          'buildpacks' => [
            {'name' => 'foo', 'url' => 'http://foo.bar' },
            {'name' => 'bar', 'url' => 'http://bar.bar' }
          ]
        }

        config = UpstreamConfig.new(hash)
        expect(config.buildpacks.length).to eq 2
        expect(config.buildpacks[0].url).to eq ("http://foo.bar")
        expect(config.buildpacks[1].url).to eq ("http://bar.bar")
      end
    end
  end
end
