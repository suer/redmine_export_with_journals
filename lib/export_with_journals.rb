class ExportWithJournalsListener < Redmine::Hook::ViewListener
  def view_issues_index_bottom(context)
    project = Project.find_by_identifier(context[:project])
    return '' unless User.current.allowed_to?(:export_csv_with_journals, context[:project], :global => true)
    html = "<div class='contextual'>"
    puts "========="
    puts context[:project]
    html << link_to(l(:label_export_with_journals), {:controller => 'issues_export', :action => 'export_with_journals', :project_id => context[:project]})
    html << '</div>'
  end
end
