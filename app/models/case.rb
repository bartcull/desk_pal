require 'desk_api'
class Case

  def self.update_first_case(label_name)
    labels = first_case["labels"] << label_name
    DeskApi.patch(first_case_endpoint, JSON.generate({ "labels" => labels.uniq.compact }))
  end
  
  def self.first_case
    all["_embedded"]["entries"].first #if all.has_key?("_embedded")
  end
  
  def self.first_case_endpoint
    first_case["_links"]["self"]["href"] if first_case.has_key?("_links")
  end
  
  def self.all(endpoint=nil)
    endpoint = Filter.new.first_filter_cases_endpoint if endpoint.nil?
    parsed_response = DeskApi.get(endpoint)
  end
  
end