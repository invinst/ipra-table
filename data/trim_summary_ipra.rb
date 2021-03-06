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
    "Documents:",
    "Docs Withheld Notes:",
  ]

  original_csv.each do |uncleaned_row|

    row = CleanRow.new uncleaned_row

    names_explanation = case row.complaint_number
    when "1053667.0"
      "ANTHONY ROSEN, MICHAEL GONZALEZ JR, MANUEL MENDEZ JR, DANIEL LOPEZ, \
      MICHAEL CURRY, TERRENCE PRATSCHER, VIOLET REY"
    when "1078329.0"
      "SEAN TULLY (see <strong>
              <a href='https://github.com/invinst/ipra-table/blob/master/data/AMBIGUOUS.md'>
                data/AMBIGUOUS.md
              </a>
            </strong> for more information.)"
    end

    trimmed_csv << [
      row.complaint_number,
      row.complaint_date,
      names_explanation || row.cleaned_accused_names,
      row.incident_links,
      row.docs_withheld
    ]
  end

end
