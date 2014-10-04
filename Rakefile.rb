require 'rake/testtask'

Rake::TestTask.new(:feature) do |t|
  t.libs = ['lib', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/feature/*_spec.rb']
end

Rake::TestTask.new(:unit) do |t|
  t.libs = ['lib/follower_maze', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/unit/*_spec.rb']
end

task default: [:unit, :feature]
