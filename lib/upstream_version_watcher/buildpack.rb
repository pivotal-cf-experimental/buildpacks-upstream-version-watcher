module UpstreamVersionWatcher
  class Buildpack
    attr_reader :url, :branch

    DEFAULT_BRANCH = "master"

    def initialize hash
      raise ArgumentError.new("'url' is required") unless @url = hash["url"]
      @branch = hash["branch"] || DEFAULT_BRANCH
    end
  end
end