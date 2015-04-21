json.array!(@sections) do |section|
  json.extract! section, :id, :title, :subtitle, :assessment_id
  json.url section_url(section, format: :json)
end
