class CleanRow < Struct.new :row

  def accused_fnames
    row[:accused_officer_fname].gsub("\n", "").split("' '")
  end

  def accused_lnames
    row[:accused_officer_lname].gsub("\n", "").split("' '")
  end

  def accused_bothnames

    if accused_fnames.size != accused_lnames.size
      p '!!!!!!'

      p accused_fnames
      p accused_lnames
    end

    accused_fnames.zip(accused_lnames).map do |pair_of_names|
      pair_of_names.join(' ')
    end.to_s
  end

  def cleaned_accused_names
    clean_names_string(accused_bothnames)
  end

  def clean_names_string(names_string)
    names_string.gsub("None", "")
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
      "<a href=#{url} target='_blank'>doc</a>"
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
