class CleanRow < Struct.new :row

  def accused_fnames
    row[:accused_officer_fname].split("' '")
  end

  def accused_lnames
    row[:accused_officer_lname].split("' '")
  end

  def accused_bothnames
    accused_fnames.zip(accused_lnames).map do |pair_of_names|
      pair_of_names.join(' ')
    end.to_s
  end

  def cleaned_names
    accused_bothnames.gsub("None", "")
                     .gsub("[", "")
                     .gsub("]", "")
                     .gsub("'", "")
                     .gsub("\"", "")
                     .gsub('\n', "")
  end

  def public_urls
    row[:public_url].gsub("\"", "").gsub("'", "").split("\n")
  end

  def incident_links
    public_urls.map do |url|
      "<a href=#{url} target='_blank'>#{url.split('.')[1]}</a>"
    end.join(', ')
  end

  def docs_withheld
    if row[:docs_withheld_notes] == "'novalue'"
      '—'
    else
      row[:docs_withheld_notes].gsub("'", "")
    end
  end

  def complaint_date
    if row[:complaint_date] == "None"
      '—'
    else
      row[:complaint_date].gsub("None", "").gsub("'", "")
    end
  end

  def complaint_number
    row[:complaint_number]
  end

end
