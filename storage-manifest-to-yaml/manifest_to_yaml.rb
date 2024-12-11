# frozen_string_literal: true

require 'json'
require 'yaml'
require 'nokogiri'

## Convert a storage manifest to Yaml
class ManifestToYaml
  XMLNS = 'http://uc3.cdlib.org/ontology/mrt/manifest'

  def load_xml(xmlbody)
    manifest = {}
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
          key = f.xpath('key').text.split('|')[1]
          manifest[:files][f['id']] = manifest[:files].fetch(f['id'], {})
          file = manifest[:files][f['id']]

          file[:versions] = file.fetch(:versions, {})
          vers = file[:versions]
          if key.to_i == v
            vers[v] = vers.fetch(v, {})
            rec = vers[v]
            rec[:creation_date] = f.xpath('creationDate').text
            rec[:digest] = f.xpath('digest').text
            rec[:digestType] = f.xpath('digestType').text
            rec[:size] = f.xpath('size').text.to_i
            rec[:mime_type] = f.xpath('mimeType').text
            rec[:key] = f.xpath('key').text
            rec[:current] = true if v == last_version
          else
            vers[key.to_i][:refs] = vers[key.to_i].fetch(:refs, [])
            vers[key.to_i][:refs].append(v)
            if v == last_version
              vers[key.to_i][:current] = true
              vers[key.to_i].delete(:refs) if vers[key.to_i][:refs].length == v - key.to_i
            end
          end
        end
      end
    end
    manifest[:files] = manifest.fetch(:files, []).sort.to_h
    manifest[:files].each_key do |f|
      current = false
      manifest[:files][f][:versions].each_value do |fv|
        next unless fv.key?(:current)

        current = true
        break
      end
      manifest[:files][f][:DELETED] = true unless current
    end
    manifest = JSON.parse(manifest.to_json)
    "# See https://github.com/CDLUC3/merritt-tinker/tree/main/yaml-manifest for more info\n#{YAML.dump(manifest)}"
  end
end

manifest = ManifestToYaml.new.load_xml(File.read(ARGV[0]))
puts YAML.dump(manifest)