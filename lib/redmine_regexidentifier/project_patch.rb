module RedmineRegexidentifier
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        validate :validate_identifier_regex, on: :create
      end
    end

    def validate_identifier_regex
      if Setting.plugin_redmine_regexidentifier['enabled']
        regex_string = Setting.plugin_redmine_regexidentifier['regex']
        regex_string_without_linebreaks = regex_string.gsub(/[\r\n]+/, '')
        regex = Regexp.new(regex_string_without_linebreaks)
        unless regex.match(identifier)
          errors.add(:identifier, :invalid)
        end
      end
    end
  end
end
