class Open311
  include HTTParty

  base_uri ENV["OPEN311_BASE_URL"]

  def service_list
    Open311.get("/services.json").inject([]) { |acc, curr| acc << curr }
  end

  def service(service_code)
    response = Open311.get("/services/#{service_code}.json")
    response.keys.inject({}) { |acc, curr| acc[curr] = response[curr]; acc }
  end

  def post_request(params)
    # $stderr.puts "New Request: #{params.inspect}"
    response = Open311.post("/requests.json", :body => params.merge(:api_key => ENV["OPEN311_API_KEY"]))
    # $stderr.puts "New Request Response: #{response.inspect}"
    response.first["token"]
  end

  def service_request_id_from_token(token)
    # $stderr.puts "Request Service ID for token: #{token}"
    response = Open311.get("/tokens/#{token}.json")
    # $stderr.puts "Request Service ID Response: #{response.inspect}"
    response.first["service_request_id"]
  end

  def get_request(service_request_id)
    Open311.get("/requests/#{service_request_id}.json").first
  end
end
