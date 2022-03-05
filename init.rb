require 'redmine'
require File.expand_path('../lib/export_with_journals_listener', __FILE__)

Redmine::Plugin.register :redmine_export_with_journals do
  name 'Redmine Export With Journals plugin'
  author 'suer'
  description 'Export CSV with Journals'
  version '0.1.0'
  url 'https://github.com/suer/redmine_export_with_journals'
  author_url 'http://d.hatena.ne.jp/suer'
  permission :export_csv_with_journals, {:issues_export => :export_with_journals}
end
