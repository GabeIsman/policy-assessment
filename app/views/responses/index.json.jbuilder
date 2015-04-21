json.array!(@responses) do |response|
  json.extract! response, :id, :email, :ip, :location
  json.url response_url(response, format: :json)
end
