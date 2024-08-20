require 'redmine'

Redmine::Plugin.register :redmine_regexidentifier do
  name 'Redmine Regex Identifier Plugin'
  author 'Markus Boremski'
  description 'This plugin checks the project identifier against a regex.'
  version '0.0.3'
  url 'https://github.com/mboremski/redmine_regexidentifier'
  author_url 'https://github.com/mboremski'
  settings default: {'regex' => '\Aed[0-9]*\z', 'enabled' => true}, partial: 'settings/redmine_regexidentifier_settings'
end

Rails.configuration.to_prepare do
  require_dependency 'project'
  require_dependency File.expand_path('../lib/redmine_regexidentifier/project_patch', __FILE__)

  Project.include RedmineRegexidentifier::ProjectPatch
end
