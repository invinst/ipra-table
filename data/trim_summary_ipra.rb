require 'csv'
require './clean_row'

PATH = './summary_ipra.csv'

def convert_nan(field)
end

original_csv = CSV.read(PATH, headers: true,
                              header_converters: :symbol,
                              converters: lambda { |field|
                                field.gsub("nan", "None")
                                     .gsub("[", "")
                                     .gsub("]", "")
                              }
                        )

CSV.open("trimmed_summary_ipra.csv", "wb") do |trimmed_csv|

  trimmed_csv << [
    "Complaint number:",
    "Complaint date:",
    "Accused officer names:",
    "Involved officer names:",
    "Documents:",
    "Docs Withheld Notes:",
  ]

  original_csv.each do |uncleaned_row|
    if uncleaned_row[:accused_officer_fname] != "None"

      row = CleanRow.new uncleaned_row

      trimmed_csv << [
        row.complaint_number,
        row.complaint_date,
        row.cleaned_accused_names,
        row.cleaned_involved_names,
        row.incident_links,
        row.docs_withheld
      ]
    end
  end
end
