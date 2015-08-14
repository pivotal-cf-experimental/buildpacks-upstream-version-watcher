module UpstreamVersionWatcher
  class Buildpack
    attr_reader :url, :name, :branch, :dependencies

    DEFAULT_BRANCH = 'master'
    MANIFEST_NAME  = 'manifest.yml'

    def initialize(hash)
      @name         = hash['name']
      @url          = hash['url']          || raise(ArgumentError.new("'url' is required"))
      @branch       = hash['branch']       || DEFAULT_BRANCH
      @dependencies = hash['dependencies'] || {}
    end
  end
end
