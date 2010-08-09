#
# Cookbook Name:: ci_setup
# Recipe:: default
#

# ensure we only deploy to the staging server
node[:applications].each do |app_name, data|
  next unless app_name == "YOUR_APP_NAME"
  next unless data["vhosts"].first["role"] == "staging"
 
  # configuration
  user = node[:users].first

  repo_path  = "/data/#{app_name}/shared/repos"
  repo_name  = "YOUR_REPO_NAME"

  github_url = "YOUR_GITHUB_REPO_URL" # repo you want to test against
  
  # create the repos directory
  directory "#{repo_path}" do
    owner       user[:username]
    group       user[:username]
    mode        "0755"
    action      :create
    recursive   true
  end
  
  # clone the Woople repository
  execute "cloning-repository" do
    cwd     "#{repo_path}"
    user    user[:username]
    command "git clone #{github_url}"
    not_if do File.directory?("#{repo_path}/#{repo_name}/.git") end
  end
  
  # we need to setup a test database connection
  template "/data/#{app_name}/shared/config/database.yml" do
    source  "database.yml.erb"
    owner   user[:username]
    group   user[:username]
    mode    "0744"
    variables({
      :db_name  => "#{app_name}",
      :db_user  => user[:username],
      :db_pass  => user[:password]
    })
  end
end