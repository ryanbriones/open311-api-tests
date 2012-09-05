When "I create a new request" do
  @request_response = Open311.new.post_request(:service_code => "4ffa4c69601827691b000018", 
                                               :lat => "41.8836379", 
                                               :long => "-87.6302312", 
                                               :attribute => {
                                                 "HOWMANYD" => rand(20) + 1,
                                                 "FQSKA3" => "CRM",
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
