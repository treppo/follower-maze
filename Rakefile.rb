require 'rake/testtask'

Rake::TestTask.new(:e2e) do |t|
  t.libs = ['lib', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/end-to-end/*_spec.rb']
end

Rake::TestTask.new(:unit) do |t|
  t.libs = ['lib/follower_maze', 'spec']
  t.options = '-v'
  t.test_files = FileList['spec/unit/*_spec.rb']
end

task default: [:unit, :e2e]
