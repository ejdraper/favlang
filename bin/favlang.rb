require 'bundler/setup'
Bundler.require
Dotenv.load!

['github', 'language'].each do |dep|
  require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', dep))
end

username = ARGV[0]
raise "No username specified!" if username.nil? || username.empty?

repos = GitHub.get_repositories(username)
lang = Language.favourite_language(repos)
puts "#{username}'s favourite language seems to be #{lang}"