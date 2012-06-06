# -*- coding: utf-8 -*-

require 'pit'

module Pori
  class Commands
    def initialize(args)
      @args = args

      config = Pit.get("bitbucket", :require  => {
        "username"  => "your account in bitbucket",
        "password"  => "your password in bitbucket"
      })
      @username = config['username']
      @password = config['password']
    end

    def self.run(args)
      self.new(args).run
    end

    def run
      # 今は決め打ち、動的に変更する
      self.send('create')
    end

    def create
      repo = new_repo_name

      puts "curl --request POST --user #{@username}:#{@password.chars.map{|c| '*'}.join} https://api.bitbucket.org/1.0/repositories/ --data name=#{repo} --data scm=git --data is_private=true"
      system "curl --request POST --user #{@username}:#{@password} https://api.bitbucket.org/1.0/repositories/ --data name=#{repo} --data scm=git --data is_private=true"
      puts "git remote add origin ssh://git@bitbucket.org/#{@username}/#{repo}.git"
      system "git remote add origin ssh://git@bitbucket.org/#{@username}/#{repo}.git"
    end

    private
    def new_repo_name
      raise Exception, "Not a git repository" unless is_git_repo?
      Dir.pwd.split('/')[-1]
    end

    def is_git_repo?
      system('git rev-parse --git-dir >/dev/null 2>&1;')
    end
  end
end
