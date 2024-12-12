# Provenance Manifest Tools

## Convert Manifest (storage manifest or provenance manifest) to Yaml

- `bundle install`
- Save provenance_manifest.xml from Merritt UI
- `bundle exec ruby manifest_to_yaml.rb <filename>`

## Generate Key List (storage manifest or provenance manifest)

- save storage manifest (xml)
- generate key list m.txt
- save provenance manifest (xml)
- generate key list pm.txt
- diff m.txt pm.txt

Results are sorted by checksum in order to align key differences and to provide identity.  

```
cdl-tbrady-6m:storage-manifest-to-yaml tbrady$ bundle exec ruby keys.rb provenance_manifest.xml > pm.txt
cdl-tbrady-6m:storage-manifest-to-yaml tbrady$ bundle exec ruby keys.rb manifest.xml > m.txt
cdl-tbrady-6m:storage-manifest-to-yaml tbrady$ diff m.txt pm.txt
3d2
< 2fae1024c98e94b9a6b9f47c36099f101c7ce2c9cdad6624c84200de66c31a5e      ark:/13030/m5h77m5s/1/system/provenance_manifest.xml
7c6
< c71c2c1229acbe476a5fa95c839ef50d4534a5295ef04bfed169cc4e4af1b4a4      ark:/13030/m5h77m5s/1/producer/nuxeo.cdlib.org/Nuxeo/nxfile/default/04c43a06-3005-4bf4-8d69-1f769db5def4/file:content/ucm_mclean_001.zip
---
> c71c2c1229acbe476a5fa95c839ef50d4534a5295ef04bfed169cc4e4af1b4a4      ark:/13030/m5h77m5s/1/producer/nuxeo.cdlib.org/Nuxeo/nxfile/default/04c43a06-3005-4bf4-8d69-1f769db5def4/file:content/ucm_mclean_001.zip?changeToken=22-1
```