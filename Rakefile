require 'bundler'
Bundler::GemHelper.install_tasks

namespace :test do

  desc 'integration tests'
  task :integration do
    $LOAD_PATH.unshift('spec')
    Dir.glob('./spec/integration.rb') { |f| require f }
  end

end