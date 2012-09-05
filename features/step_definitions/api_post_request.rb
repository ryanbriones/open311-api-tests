When "I create a new request" do
  locations = [
    ["41.8836379", "-87.6302312"],
    ["41.8819911", "-87.6337659"],
    ["41.8891398", "-87.6442372"],
    ["41.9005122", "-87.6315450"],
    ["41.9078026", "-87.6299786"],
  ]

  colors = %w/CRM BLK BLU BRO GRN SIL YEL/

  random_location = locations.shuffle.first
  random_color = colors.shuffle.first
  @request_response = Open311.new.post_request(:service_code => "4ffa4c69601827691b000018", 
                                               :lat => random_location[0],
                                               :long => random_location[1],
                                               :attribute => {
                                                 "HOWMANYD" => rand(20) + 1,
                                                 "FQSKA3" => random_color,
                                                 "FQSKA4" => "123456",
                                                 "FQSKA11" => "4D"
                                              })
  @request_response.should_not be_nil
end

When "I retrieve the Service ID using the request token" do
  open311 = Open311.new
  tries = 0
  try_delays = [0, 30, 60, 10, 10, 10]

  loop do
    @service_request_id = open311.service_request_id_from_token(@request_response)
    break if @service_request_id

    tries += 1
    break unless try_delays[tries]

    puts "Waiting another #{try_delays[tries]} seconds for new request to be processed"
    sleep try_delays[tries]
  end

  @service_request_id.should_not be_nil
end

Then "I should be able to retrieve the request" do
  @request = Open311.new.get_request(@service_request_id)
  @request["service_code"].should == "4ffa4c69601827691b000018"
end

When "I create a new request with missing required attributes" do
  request_params = {
   :service_code => "4ffa4c69601827691b000018",
   :lat => "41.8836379",
   :long => "-87.6302312",
   :attribute => {
     "FQSKA3" => "CRM",
     "FQSKA4" => "123456",
     "FQSKA11" => "4D"
   }
  }

  begin
    @request_response = Open311.new.post_request(request_params)
  rescue Open311::APIError => e
    @request_response_error = e
  end
end

Then "the response should be a failure" do
  @request_response_error.api_error_code.should == 400
end

Then "the message should include a validation error" do
  @request_response_error.api_error_message.should include("HOWMANYD required")
end