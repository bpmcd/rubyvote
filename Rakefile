require 'rubygems'
require 'rake'
require 'rake/testtask'

# Run the unit tests
Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = 'test/*_test.rb'
  t.verbose = true
}

