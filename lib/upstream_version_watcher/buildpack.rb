module UpstreamVersionWatcher
  class Buildpack
    attr_reader :url, :name, :branch, :dependencies

    DEFAULT_BRANCH = 'master'
    MANIFEST_PATH  = 'manifest.yml'

    def initialize(hash)
      @name         = hash['name']
      @url          = hash['url']          || raise(ArgumentError.new("'url' is required"))
      @branch       = hash['branch']       || DEFAULT_BRANCH
      @dependencies = hash['dependencies'] || {}
    end

    def manifest
      @manifest ||= clone_manifest
    end

    def clone_manifest
      manifest = nil
      Dir.chdir(Dir.mktmpdir) do
        `git clone --depth 1 "#{@url}" --branch "#{@branch}"`
        manifest = YAML.load_file(File.join(File.basename(@url), MANIFEST_PATH))
      end
      manifest
    end
  end
end
