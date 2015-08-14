def create_git_repo(repository_name)
  path = repository_path(repository_name)
  FileUtils.mkdir(path)
  Dir.chdir(path) do
    %x(
    git init -q
    git #{committer_info} commit -q --allow-empty -m "Initial Commit"
    )
  end
  path
end

def create_git_tag(repository_path, options = {})
  tag_name = options[:tag_name] || random_tag_name
  Dir.chdir(repository_path) do
    %x(
      git #{committer_info} tag #{tag_name}
    )
  end
end

def random_tag_name
  "v#{rand(10)}.0"
end

def committer_info
  "-c user.name='test' -c user.email='test@example.com'"
end

def repository_path(repository_name)
  "#{Dir.mktmpdir}/#{repository_name}"
end
