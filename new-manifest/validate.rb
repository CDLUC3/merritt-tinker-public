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
obj = YAML.safe_load(
  File.read('manifest.sample.yml'), 
  aliases: true
)
schema = JSON.parse(File.read("merritt-manifest-schema.json"))
stat = JSON::Validator.fully_validate(schema, obj)
puts stat
