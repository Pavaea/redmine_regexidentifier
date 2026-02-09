module RedmineRegexidentifier
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        # Die Validierung soll beim erstellen prüfen
        validate :validate_identifier_regex, on: :create
      end
    end

    def validate_identifier_regex
      # 1. Prüfen, ob das Plugin in den Einstellungen aktiviert ist
      if Setting.plugin_redmine_regexidentifier && Setting.plugin_redmine_regexidentifier['enabled']
        
        regex_string = Setting.plugin_redmine_regexidentifier['regex']
        
        # Falls kein Regex eingetragen wurde, nichts tun
        return if regex_string.blank?

        begin
          # Regex säubern (Linebreaks entfernen) und initialisieren
          regex = Regexp.new(regex_string.gsub(/[\r\n]+/, ''))
          
          # 2. Den Identifier gegen die Regex prüfen
          unless regex.match(identifier)
            # Fehlermeldung ausgeben, wenn es nicht passt
            errors.add(:identifier, "entspricht nicht dem erforderlichen Muster (#{regex_string})")
          end
        rescue RegexpError => e
          # Falls die eingegebene Regex im Admin-Bereich ungültig ist
          errors.add(:identifier, "konnte nicht geprüft werden, da die Regex ungültig ist.")
        end
      end
    end
  end
end
