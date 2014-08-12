class Settings < Settingslogic
  source "#{Rails.root}/config/main_config.yml"
  namespace Rails.env
end
