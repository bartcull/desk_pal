require 'spec_helper'
require 'desk_api'

describe DeskApi do
  let(:labels_response) { File.new('spec/stub/labels.json') }
  let(:new_label_response) { File.new('spec/stub/new_label.json') }
  let(:failed_new_label_response) { File.new('spec/stub/failed_new_label.json') }
  let(:updated_label_response) { File.new('spec/stub/updated_label.json') }
  let(:filters_response) { File.new('spec/stub/filters.json') }
  let(:json_body) { '{"json":"body"}' }
  let(:json_post_success) { '{"json":"post success"}' }
  let(:json_post_fail) { '{"json":"post fail"}' }
  
  subject { DeskApi }
  context ".get" do
    it "calls a service and gets a parsed response" do
      stub_request(:get, LABELS_ENDPOINT).to_return(labels_response)
      subject.get(LABELS_ENDPOINT).should be_a(Hash)
    end
  end
  
  context ".post" do
    it "posts json to the api and return 201 for success" do
      stub_request(:post, LABELS_ENDPOINT).with(:body => json_post_success).to_return(new_label_response)
      subject.post(LABELS_ENDPOINT, json_post_success).code.should eq('201')
    end
    it "posts json to the api and returns 422 for failure" do
      stub_request(:post, LABELS_ENDPOINT).with(:body => json_post_fail).to_return(failed_new_label_response)
      new_label = subject.post(LABELS_ENDPOINT, json_post_fail).code.should eq('422')
    end
  end

  context ".patch" do
    it "uses a X-HTTP-Method-Override header and returns 200 for success" do
      stub_request(:post, LABELS_ENDPOINT).with(:headers=>{ 'X-Http-Method-Override'=>'PATCH' }).to_return(updated_label_response)
      subject.patch(LABELS_ENDPOINT, json_body).code.should eq('200')
    end
  end

  context ".all_labels" do
    it "calls the labels service and gets a parsed response" do
      stub_request(:get, LABELS_ENDPOINT).to_return(labels_response)
      subject.all_labels.should have_key("_embedded")
    end
  end
  
  context ".all_filters" do
    it "calls the filters service and gets a parsed response" do
      stub_request(:get, FILTERS_ENDPOINT).to_return(filters_response)
      subject.all_filters.should have_key("_embedded")
    end
  end
end
