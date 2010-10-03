module IssuesExportHelper
  def add_journals(csv)
    FasterCSV.generate do |newcsv|
      FasterCSV.parse(csv.toutf8, :headers => true, :return_headers => true) do |row|
        if row.header_row?
          newcsv << row.fields + [t(:label_history)]
        else
          newcsv << row.fields + Issue.find(row.fields.first).journals.map {|j| j.user.name + "\n" + (j.notes.nil? ? '' :     j.notes)}
        end
      end
    end.tosjis
  end
end
