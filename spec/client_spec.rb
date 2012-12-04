require 'spec_helper'

describe SteamClient::Client do 
  
  it "should instantiate" do
    client = SteamClient::Client.new("XXXXXXXXX")
    client.api_key.should == "XXXXXXXXX"
  end
  
  it "should get a profile" do
    client = SteamClient::Client.new("XXXXXXXXX")
    profile = client.get_profile("some_person")
    profile.class.should == SteamClient::Profile.class
  end
end