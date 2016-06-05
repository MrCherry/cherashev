config_file = File.expand_path("../puma/#{ENV['RAILS_ENV']}.rb", __FILE__)
config_content = File.read(config_file)
instance_eval(config_content)
