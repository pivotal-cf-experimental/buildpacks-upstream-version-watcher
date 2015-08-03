module UpstreamVersionWatcher
  class Buildpack
    attr_reader :url, :branch, :dependencies

    DEFAULT_BRANCH = "master"
    MANIFEST_NAME = "manifest.yml"

    def initialize hash
      raise ArgumentError.new("'url' is required") unless @url = hash["url"]
      @branch = hash["branch"] || DEFAULT_BRANCH
      @dependencies ||= hash["dependencies"] || {}
    end
  end
end
