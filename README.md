> yaml配置
```yaml
dependencies:
  intl: ^0.18.0
  
dev_dependencies:
  build_runner: ^2.4.4
  isar_generator: ^3.1.0

flutter_intl:
  enabled: true # Required. Must be set to true to activate the package. Default: false
  class_name: S # Optional. Sets the name for the generated localization class. Default: S
  main_locale: en # Optional. Sets the main locale used for generating localization files. Provided value should consist of language code and optional script and country codes separated with underscore (e.g. 'en', 'en_GB', 'zh_Hans', 'zh_Hans_CN'). Default: en
  arb_dir: lib/l10n # Optional. Sets the directory of your ARB resource files. Provided value should be a valid path on your system. Default: lib/l10n
  output_dir: lib/generated # Optional. Sets the directory of generated localization files. Provided value should be a valid path on your system. Default: lib/generated
  use_deferred_loading: false # Optional. Must be set to true to generate localization code that is loaded with deferred loading. Default: false
  localizely: # Optional settings if you use Localizely platform. Read more: https://localizely.com/blog/flutter-localization-step-by-step/?tab=automated-using-flutter-intl
    project_id: # Get it from the https://app.localizely.com/projects page.
    branch: # Get it from the “Branches” page on the Localizely platform, in case branching is enabled and you want to use a non-main branch.
    upload_overwrite: # Set to true if you want to overwrite translations with upload. Default: false
    upload_as_reviewed: # Set to true if you want to mark uploaded translations as reviewed. Default: false
    upload_tag_added: # Optional list of tags to add to new translations with upload (e.g. ['new', 'New translation']). Default: []
    upload_tag_updated: # Optional list of tags to add to updated translations with upload (e.g. ['updated', 'Updated translation']). Default: []
    upload_tag_removed: # Optional list of tags to add to removed translations with upload (e.g. ['removed', 'Removed translation']). Default: []
    download_empty_as: # Set to empty|main|skip, to configure how empty translations should be exported from the Localizely platform. Default: empty
    download_include_tags: # Optional list of tags to be downloaded (e.g. ['include', 'Include key']). If not set, all string keys will be considered for download. Default: []
    download_exclude_tags: # Optional list of tags to be excluded from download (e.g. ['exclude', 'Exclude key']). If not set, all string keys will be considered for download. Default: []
    ota_enabled: # Set to true if you want to use Localizely Over-the-air functionality. Default: false
```