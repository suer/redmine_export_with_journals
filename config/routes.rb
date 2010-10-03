ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'issues_export' do |issues_export|
    issues_export.connect 'projects/:project_id/issues_export/:action'
  end
end
