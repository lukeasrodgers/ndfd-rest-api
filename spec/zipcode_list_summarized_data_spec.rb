require 'spec_helper'

describe NdfdRestApi::ZipcodeListSummarizedData do

  describe ".fetch" do
    before(:each) do
      NdfdRestApi::SummarizedNdfdResponse.stub(:new)
      NdfdRestApi::SummarizedData.stub(:new)
    end
    it "should make a call to http service with right default params" do
      NdfdRestApi::HttpService.should_receive(:get).with(:summarized, {:zipCodeList => "11238", :format => "12 hourly", :numDays => 1, :unit => "e"})
      NdfdRestApi::ZipcodeListSummarizedData.fetch([11238], {})
    end
    it "should make a call to http service with right default params" do
      NdfdRestApi::HttpService.should_receive(:get).with(:summarized, {:zipCodeList => "11238", :format => "24 hourly", :numDays => 7, :unit => "e"})
      NdfdRestApi::ZipcodeListSummarizedData.fetch([11238], {:days => 7, :format => "24 hourly"})
    end
  end

end
