# CIJOE
# Continuous Integration Settings
SHARED_REPO  = "#{shared_path}/repos"
CURRENT_REPO = "#{current_path}/repos"

# update these values (this is not run in the context of config.ru)
REPO_NAME    = "YOUR_REPO_NAME"
BRANCH_NAME  = "YOUR_REPO_BRANCH"

# setup the repo with hooks and config
Dir.chdir("#{SHARED_REPO}/#{REPO_NAME}") do
    
  # initialize any new submodules, etc
  `git submodule init`
  `git submodule update`

  # always re-configure the CI Joe settings
  `git config --remove-section cijoe`

  `git config --add cijoe.runner "RAILS_ENV=test rake -s test"`
  `git config --add cijoe.branch #{BRANCH_NAME}`
  `git config --add cijoe.buildallfile #{current_path}/tmp/cijoe.txt`

  # always copy the git hooks
  `cp #{current_path}/lib/hooks/* .git/hooks`
  `chmod +x .git/hooks/*`

end

# symlink repo directory
Dir.chdir("#{current_path}") do
  `ln -sf #{SHARED_REPO} #{CURRENT_REPO}`
end