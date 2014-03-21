require 'spec_helper'
describe Label do
  let(:labels_response) { File.new('spec/stub/labels.json') }
  let(:label_hash) { {"_links"=>{"self"=>{"href"=>"/my/fake/link/id" } } } }
  let(:new_label) { { name: 'test', description: 'test', types: ['case'], color: 'default' } }
  let(:new_label_enabled) { new_label.merge({enabled: true}) }
  let(:new_label_json) { JSON.generate(new_label_enabled) }
  let(:bad_label) { { name: 'test' } }
  let(:new_label_response) { File.new('spec/stub/new_label.json') }
  let(:failed_new_label_response) { File.new('spec/stub/failed_new_label.json') }
  
  before do
    stub_request(:get, LABELS_ENDPOINT).to_return(labels_response)
  end
  
  subject { Label }
  context '.all' do
    it 'returns an array of labels' do
      all_labels = subject.all
      all_labels.should be_an(Array)
      all_labels.count.should eq(13)
    end
  end
  
  context '.all_enabled' do
    it 'returns an array of labels' do
      enabled_labels = subject.all_enabled
      enabled_labels.should be_an(Array)
      enabled_labels.count.should eq(12)
    end
  end
  
  context '.link_id' do
    it 'returns nil if the label_hash is missing or empty' do
      subject.link_id(nil).should be_nil
      subject.link_id([]).should be_nil
    end
    it 'finds the id from a link' do
      subject.link_id(label_hash).should eq('id')
    end
  end
  
  context '#find_by_name' do
    it 'returns a label with a specific name' do
      subject.new.find_by_name('Escalated').first['name'].should eq('Escalated')
    end
  end

  context '.destroy' do
    it 'sets enabled to false' do
      DeskApi.should_receive(:patch).with("https://cullimore.desk.com/api/v2/labels/2", "{\"enabled\":false}").and_return(true)      
      subject.destroy(2)
    end
  end
  
  context '#save' do
    it 'validates presence of name, description, types, and color' do
      subject.new(bad_label).save.should be_false
    end
    it 'saves a new label' do
      stub_request(:post, LABELS_ENDPOINT).with(:body => new_label_enabled).to_return(new_label_response)
      subject.new(new_label).save.should be_true
    end
    it 'enables an existing disabled label if the save fails' do
      stub_request(:post, LABELS_ENDPOINT).with(:body => new_label_enabled).to_return(failed_new_label_response) #forcing code 422
      response = double
      response.stub(:code) { '200' }
      DeskApi.should_receive(:patch).with("https://cullimore.desk.com/api/v2/labels/1708134", new_label_json).and_return(response)
      subject.new(new_label).save.should be_true
    end
  end
end
