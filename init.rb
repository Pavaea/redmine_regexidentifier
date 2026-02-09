require 'redmine'

# 1. Plugin Registrierung
Redmine::Plugin.register :redmine_regexidentifier do
  name 'Redmine Regex Identifier Plugin'
  author 'Markus Boremski'
  description 'This plugin checks the project identifier against a regex.'
  version '0.0.3'
  url 'https://github.com/mboremski/redmine_regexidentifier'
  author_url 'https://github.com/mboremski'
  settings default: {'regex' => '\Aed[0-9]*\z', 'enabled' => true}, 
           partial: 'settings/redmine_regexidentifier_settings'
end

# 2. Patch sofort erzwingen
require 'project'

require_dependency File.expand_path('../lib/redmine_regexidentifier/project_patch', __FILE__)
unless Project.included_modules.include?(RedmineRegexidentifier::ProjectPatch)
  Project.send(:include, RedmineRegexidentifier::ProjectPatch)
  # Diese Zeile MUSST du in den Docker-Logs sehen
  puts "================================================"
  puts "!!! REGEX-PLUGIN: Patch wurde geladen !!!"
  puts "================================================"
end