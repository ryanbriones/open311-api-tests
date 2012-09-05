When "I call the Service API via GET" do
  @service = Open311.new.service("4ffa4c69601827691b000018")
end

Then "I should get back a list of service attributes" do
  @service["attributes"].should_not be_empty
end
