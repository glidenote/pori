# -*- coding: utf-8 -*-

require 'pit'
require 'httparty'

module Pori
  class Commands
    def initialize(*args)
      @command = args.empty? ? :create : args.shift.to_sym

      config = Pit.get("bitbucket",
        require: {
          "username" => "your account in bitbucket",
          "password" => "your password in bitbucket"
        }
      )

      @options   = {
        basic_auth: { username: config['username'], password: config['password'] },
        headers:    { "User-Agent" => "Pori #{Pori::VERSION} - https://github.com/glidenote/pori" }
      }

      @repo      = repo_name
      @username  = config['username']
    end

    def self.run(*args)
      self.new(*args).run
    end

    def run
      self.send(@command)
    end

    def create
      endpoint = 'https://api.bitbucket.org/1.0/repositories/'

      @options.merge!(
        { body:
          { name: @repo, scm: "git", is_private: "true" }
        }
      )
      response = HTTParty.post(endpoint, @options)

      if response.code.to_i == 200
        puts "Successfully created."
        puts "git remote add origin ssh://git@bitbucket.org/#{@username}/#{@repo}.git"
        system "git remote add origin ssh://git@bitbucket.org/#{@username}/#{@repo}.git"
      else
        $stdout.puts "Something was wrong... o_O"
        $stdout.puts
        $stdout.puts response
      end
    end

    def delete
      if del_flags
        endpoint = "https://api.bitbucket.org/1.0/repositories/#{@username}/#{@repo}"
        response = HTTParty.delete(endpoint, @options)
        if response.code.to_i == 204
          puts "Successfully deleted."
        else
          $stdout.puts "Something was wrong... o_O"
          $stdout.puts
          $stdout.puts response
        end
      else
        puts "Canceled."
      end
    end

    private
    def repo_name
      raise Exception, "Not a git repository" unless is_git_repo?
      tmp_dir = `git rev-parse -q --git-dir`.chomp
      if tmp_dir == ".git"
        repo_name = File.basename(Dir.pwd)
      else
        repo_dir_name = File.dirname("#{tmp_dir}")     # => /Users/akira/repos/pori/.git
        repo_name = File.basename("#{repo_dir_name}")  # => pori
      end
      repo_name
    end

    def is_git_repo?
      system('git rev-parse --git-dir >/dev/null 2>&1;')
    end

    def del_flags
      confirm = false

      print "Please type in the name of the repository to confirm [(#{@repo})] :"
      del_repo = STDIN.gets.chomp

      if del_repo == @repo
        print "Really delete repository? [y/N] :"
        yes_or_no = STDIN.gets.chomp
        if yes_or_no =~ /yes|y/i
          confirm = true
        end
      end
    end
  end
end
