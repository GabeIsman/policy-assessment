json.array!(@assessments) do |assessment|
  json.extract! assessment, :id, :title, :subtitle, :user_id
  json.url assessment_url(assessment, format: :json)
end
