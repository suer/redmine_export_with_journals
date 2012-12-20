module IssuesExportHelper
  def add_journals(csv)
    csv_with_journals = FCSV.generate do |newcsv|
      FCSV.parse(Iconv.conv('UTF-8', 'CP932', csv), :headers => true, :return_headers => true) do |row|
        if row.header_row?
          newcsv << row.fields + [t(:label_history)]
        else
          newcsv << row.fields + Issue.find(row.fields.first).journals.map do |j| 
            j.user.name + "\n" + j.details.map {|d| show_detail(d, true)}.join("\n") + "\n" + (j.notes.nil? ? '' :     j.notes)
          end
        end
      end
    end
    Iconv.conv('CP932', 'UTF-8', csv_with_journals)
  end
end
