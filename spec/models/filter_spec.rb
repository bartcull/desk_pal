require 'spec_helper'

describe Filter do
  let(:filters_response) { File.new('spec/stub/filters.json') }
  
  before do
    stub_request(:get, FILTERS_ENDPOINT).to_return(filters_response)
  end
  
  subject { Filter.new }
  context "#first_filter" do
    it 'returns a hash of the first filter' do
      subject.first_filter.should be_a(Hash)
    end
  end
  
  context "#first_filter_name" do
    it 'returns the name of the first filter' do
      subject.first_filter_name.should eq('Inbox')
    end
  end
  
  context "#first_filter_cases_endpoint" do
    it 'returns the cases endpoint for the first filter' do
      subject.first_filter_cases_endpoint.should eq('https://cullimore.desk.com/api/v2/filters/1911492/cases')
    end
  end
end