class ExportWithJournalsListener < Redmine::Hook::ViewListener
  def view_issues_index_bottom(context)
    project = context[:project]
    return '' unless User.current.allowed_to?(:export_csv_with_journals, project, :global => true)
    context[:controller].send(:render_to_string, {
      :partial => 'hooks/export_with_journals/view_issues_index_bottom',
      :locals => {:project => project}})
  end
end
