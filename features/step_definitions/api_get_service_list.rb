When "I call the Service List API via GET" do
  @service_list = Open311.new.service_list
end

Then "I should get back a list of services and service codes available for use" do
  step "I check the number of services"
  step "I spot check the list of services; IDs to Service Names"
end

Then "I spot check the list of services; IDs to Service Names" do
  services = {"4ffa4c69601827691b000018" => "Abandoned Vehicle"}
  service_code = services.keys.shuffle.first
  service_from_api = @service_list.detect { |service| service["service_code"] = service_code }
  service_from_api["service_name"].should == services[service_code]
end

Then "I check the number of services" do
  @service_list.size.should == 14
end
