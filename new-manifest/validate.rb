require 'json'
require 'json-schema'
require 'yaml'

File.open('merritt-manifest-schema.json', 'w') do |f|  f.write(
  JSON.pretty_generate(
    YAML.safe_load(
      File.read('merritt-manifest-schema.yml'), 
      aliases: true
    )
  )
)
end

schema = JSON.parse(File.read("merritt-manifest-schema.json"))

Dir['./manifest*.yml'].each do |file|
  begin
    puts "\n\n#{file}\n\n"
    obj = YAML.safe_load(
      File.read(file), 
      # [Date, Time],
      aliases: true
    )
  rescue => e 
    puts e 
  end
  puts JSON::Validator.fully_validate(schema, obj)
end