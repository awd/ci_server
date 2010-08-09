# CIJOE
require 'cijoe'

REPO_NAME = "YOUR_REPO_NAME"

# set the $project_path global
$project_path = `pwd`.gsub(/\n/, '') + "/repos/#{REPO_NAME}"

# setup middleware
use Rack::CommonLogger

# configure joe
CIJoe::Server.configure do |config|
  config.set :project_path, $project_path
  config.set :show_exceptions, true
  config.set :lock, true
end

run CIJoe::Server