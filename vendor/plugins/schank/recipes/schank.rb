# ============
# = Personal =
# ============
namespace :schank do

  desc "Generate version.yml from variables"
  task :generate_version_info, :roles => :app do
    result = render_erb_template(File.dirname(__FILE__) + "/templates/version.yml.erb")
    put result, "#{release_path}/config/version.yml"
  end
  after "deploy:update_code", "schank:generate_version_info"

end
