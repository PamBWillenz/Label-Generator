require 'yaml'

config_file = Rails.root.join('config', 'types.yml')
if File.exist?(config_file)
  Prawn::Labels.types.merge!(YAML.load_file(config_file))
end