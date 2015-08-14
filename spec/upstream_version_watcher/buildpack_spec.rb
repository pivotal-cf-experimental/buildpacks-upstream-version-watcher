require 'spec_helper'

module UpstreamVersionWatcher
  describe Buildpack do
    subject { Buildpack.new(options) }

    describe '#new' do
      context 'when url is missing from arguments' do
        it 'should raise error' do
          expect { Buildpack.new({}) }.to raise_error(ArgumentError)
        end
      end

      context 'when valid arguments are passed' do
        let(:options) do
          {
            'url'          => 'https://foo.bar/bazz/quux',
            'name'         => 'stacy',
            'branch'       => 'develop',
            'dependencies' => {'foo' => 'bar'}
          }
        end

        it { expect(subject.url).to eq 'https://foo.bar/bazz/quux' }
        it { expect(subject.name).to eq 'stacy' }
        it { expect(subject.branch).to eq 'develop' }
        it 'gives a valid dependencies' do
          expect(subject.dependencies).to eq({'foo' => 'bar'})
        end

        context 'when no branch arguments are passed' do
          let(:options) do
            {'url' => 'https://foo.bar/bazz/quux'}
          end
          it { expect(subject.branch).to eq('master') }
        end
      end
    end
  end
end
