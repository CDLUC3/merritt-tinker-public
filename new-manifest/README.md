# New Manifest Examples

## Manifest Schema
- [Yaml schema](merritt-manifest-schema.yml)
- [JSON schema](merritt-manifest-schema.json) derived from the yaml
  - [Yaml to Json converter and validator](validate.rb)

## Sample Manfitests
- [4 blocks](manifest4blocks.yml)
  - https://github.com/CDLUC3/mrt-doc/blob/main/sampleFiles/4blocks.checkm
- [big hunt](manifest.bigHunt.yml)
  - https://github.com/CDLUC3/mrt-doc/blob/main/sampleFiles/bigHunt.checkm
- [call 911](manifest.call911.yml)
  - https://github.com/CDLUC3/mrt-doc/blob/main/sampleFiles/call911.checkm
- [manifest files](manifest.files.yml)
  - https://github.com/CDLUC3/mrt-doc/blob/main/sampleFiles/sampleBatchOfFiles.checkm
- [manifest batch](manifest.batch.yml)
  - https://github.com/CDLUC3/mrt-doc/blob/main/sampleFiles/sampleBatchOfManifests.checkm

## Execution
```
bundle install
bundle exec ruby validate.rb
```