require 'spec_helper'
require 'desk_api'

describe Case do
  let(:filters_response) { File.new('spec/stub/filters.json') }
  let(:cases_response) { File.new('spec/stub/cases.json') }
  
  before do
    stub_request(:get, FILTERS_ENDPOINT).to_return(filters_response)
    stub_request(:get, 'https://cullimore.desk.com/api/v2/filters/1911492/cases').to_return(cases_response)
  end

  subject { Case }
  context ".first_case" do
    it 'returns a hash of the first case' do
      first_case = subject.first_case
      first_case.should be_a(Hash)
      first_case['id'].should eq(2)
    end
  end

  context ".first_case_endpoint" do
    it 'returns the endpoint for the first case' do
      subject.first_case_endpoint.should eq('/api/v2/cases/2')
    end
  end

  context ".all" do
    it 'returns a hash of the cases from the first filter' do
      subject.all.should be_a(Hash)
    end
  end

  context ".update_first_case" do
    it 'adds a label to the first case' do
      DeskApi.should_receive(:patch).with("/api/v2/cases/2", "{\"labels\":[\"Example\",\"prove it\",\"myString\"]}").and_return(true)      
      subject.update_first_case('myString')
    end
  end
end
