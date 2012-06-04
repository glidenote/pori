# -*- coding: utf-8 -*-

PWD = Dir.pwd

def git_command
  `which git`.chomp
end

def current_dir
  PWD
end

def git_dir
  `#{git_command} rev-parse -q --git-dir`
end

def is_repo?
  !!git_dir
end

def new_repo_name
  is_git_repo=system("git rev-parse -q --git-dir")

  if is_git_repo
    tmp_dir = `git rev-parse -q --git-dir`.chomp
    if tmp_dir == ".git"
      repo_name = File.basename(Dir.pwd)
    else
      repo_dir_name = File.dirname("#{tmp_dir}")     # => /Users/akira/repos/pori/.git
      repo_name = File.basename("#{repo_dir_name}")
    end
  else
    raise FatalError, "Not a git repository"
  end
  repo_name
end


