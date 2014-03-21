require 'active_model'
require 'desk_api'
class Label
  include ActiveAttr::Model
  validates :name, :description, :types, :color, presence: true
  attribute :name
  attribute :description
  attribute :types
  attribute :color
  attr_accessor :name, :description, :types, :color
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def save
    return false unless self.valid?
    json_body = JSON.generate(attributes.merge({enabled: true}))
    response = DeskApi.post(LABELS_ENDPOINT, json_body)
    if response.code == '422'
      id = Label.link_id(find_by_name(name))
      response = DeskApi.patch("#{LABELS_ENDPOINT}/#{id}", json_body)
    end
    DeskApi::SUCCESS_CODES.include? response.code
  end
  
  def self.destroy(id)
    response = DeskApi.patch("#{LABELS_ENDPOINT}/#{id}", '{"enabled":false}')
    ## Looks like the Desk API delete method sets enabled to false and empties the types array.  But then 
    ## the label disappears from the list, making it impossible to find the label's id.  So instead
    ## of using delete, I've chosen PATCH.  This will allow a user to effectively disable or enable the label.
    # response = OAUTH_ACCESS_TOKEN.delete("#{LABELS_ENDPOINT}/#{id}")
  end
  
  def self.link_id(label_hash)
    label_hash = label_hash.first if label_hash.class == Array
    label_hash.blank? ? nil : label_hash["_links"]["self"]["href"].split('/').last
  end
    
  def find_by_name(name)
    Label.all.select { |label| label["name"] == name }
  end

  def self.all_enabled
    Label.all.select { |label| label["enabled"] == true }
  end
  
  def self.all
    parsed_response = DeskApi.all_labels
    parsed_response.blank? ? [] : parsed_response["_embedded"]["entries"]
  end
  
  def persisted?
    false
  end
end