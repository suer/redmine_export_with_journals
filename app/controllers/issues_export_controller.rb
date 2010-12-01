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

  before_filter :find_project, :only => [:export_with_journals]
  before_filter :authorize, :only => [:export_with_journals]
  def export_with_journals
    @issues = Issue.find(:all, :conditions => ['id in (?)', params[:ids]])
    csv = issues_to_csv(@issues, @project)
    
    send_data(add_journals(csv), :filename => 'export.csv', :type => 'text/csv')
  end
  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
