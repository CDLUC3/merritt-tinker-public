# frozen_string_literal: true

require 'json'
require 'yaml'
require 'nokogiri'

## Convert a storage manifest to Yaml
class ManifestKeys
  XMLNS = 'http://uc3.cdlib.org/ontology/mrt/manifest'

  def load_xml(xmlbody)
    manifest = {}
    keys = {}
    xml = Nokogiri::XML(xmlbody).remove_namespaces!
    xml.xpath('/objectInfo/object').each do |doc|
      manifest[:ark] = doc['id']
      manifest[:versions] = []
      doc.xpath('lastAddVersion').each do |el|
        manifest[:last_add_version] = el.text
      end
      manifest[:files] = {}
    end
    last_version = xml.xpath('/objectInfo/versions/version[last()]/@id').text.to_i
    xml.xpath('/objectInfo/versions/version').each do |doc|
      v = doc['id'].to_i
      doc.xpath('manifest').each do |m|
        manifest[:versions] << { num: v, created: m['created'] }
        m.xpath('file').each do |f|
          keys["#{manifest[:ark]}/#{v}/#{f['id']}"] = f.xpath('digest').text
        end
      end
    end
    keys
  end
end

manifest_keys = ManifestKeys.new.load_xml(File.read(ARGV[0]))
manifest_keys.sort_by { |k, v| v }.each do |k,v| 
  puts "#{v}\t#{k}"
end