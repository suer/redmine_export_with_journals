require 'redmine'
require 'export_with_journals'

Redmine::Plugin.register :redmine_export_with_journals do
  name 'Redmine Export With Journals plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :export_csv_with_journals, {:issues_export => :export_with_journals}
end
