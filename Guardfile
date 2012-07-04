# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', version: 2, cli: "--drb --format documentation", all_after_pass: false, all_on_start: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/osaipo_client/#{m[1]}_spec.rb" }
end
