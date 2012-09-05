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

  loop do
    break if tries > 2

    @service_request_id = open311.service_request_id_from_token(@request_response)
    break if @service_request_id

    tries += 1
    sleep 60
  end

  @service_request_id.should_not be_nil
end

Then "I should be able to retrieve the request" do
  @request = Open311.new.get_request(@service_request_id)
  @request["service_code"].should == "4ffa4c69601827691b000018"
end
