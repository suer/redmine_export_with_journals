class IssuesExportController < ApplicationController
  unloadable
  include IssuesHelper
  include IssuesExportHelper
  helper :journals
  helper :projects
  include ProjectsHelper   
  helper :custom_fields
  include CustomFieldsHelper
  helper :issue_relations
  include IssueRelationsHelper
  helper :watchers
  include WatchersHelper
  helper :attachments
  include AttachmentsHelper
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
  include IssuesHelper
  helper :timelog
  include Redmine::Export::PDF

  before_filter :find_optional_project, :only => [:export_with_journals]
  def export_with_journals
    retrieve_query
    sort_init(@query.sort_criteria.empty? ? [['id', 'desc']] : @query.sort_criteria)
    sort_update(@query.sortable_columns)
    if @query.valid?
      @issue_count = @query.issue_count
      @limit = Setting.issues_export_limit.to_i
      @issue_pages = Paginator.new self, @issue_count, @limit, params['page']
      @offset ||= @issue_pages.current.offset
      @issues = @query.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version],
                              :order => sort_clause, 
                              :offset => @offset, 
                              :limit => @limit)
      csv = issues_to_csv(@issues, @project, @query, params)
      send_data(add_journals(csv), :filename => 'export.csv', :type => 'text/csv')
    end
  end
end
