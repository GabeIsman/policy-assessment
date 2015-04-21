json.array!(@questions) do |question|
  json.extract! question, :id, :text, :more_info, :section_id, :assessment_id, :type
  json.url question_url(question, format: :json)
end
