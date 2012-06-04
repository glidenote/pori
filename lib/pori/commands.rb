# -*- coding: utf-8 -*-

require 'pit'

config = Pit.get("bitbucket", :require  => {
  "username"  => "your account in bitbucket",
  "password"  => "your password in bitbucket"
})

username = config['username']
password = config['password']

repo = new_repo_name

puts "curl --request POST --user #{username}:#{password} https://api.bitbucket.org/1.0/repositories/ --data name=#{repo} --data scm=git --data is_private=true"
system "curl --request POST --user #{username}:#{password} https://api.bitbucket.org/1.0/repositories/ --data name=#{repo} --data scm=git --data is_private=true"
puts "git remote add origin ssh://git@bitbucket.org/#{username}/#{repo}.git"
system "git remote add origin ssh://git@bitbucket.org/#{username}/#{repo}.git"
