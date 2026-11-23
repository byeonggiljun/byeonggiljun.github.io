# Enable only the demo posts needed by an integration test. Normal site builds
# keep all posts excluded; notebooks and private directories stay excluded here.
require "yaml"

config = YAML.unsafe_load_file("_config.yml")
fixtures = ARGV
excludes = Array(config["exclude"]).reject { |path| path.sub(%r{/+\z}, "") == "_posts" }
other_posts = Dir.glob("_posts/**/*").select { |path| File.file?(path) && !fixtures.include?(path) }
puts({ "exclude" => (excludes + other_posts).uniq }.to_yaml)
