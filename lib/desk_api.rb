class DeskApi
  SUCCESS_CODES = ['200', '201', '202', '204']
  DEFAULT_HEADERS = { 'Accept' => 'application/json', 'content-type' => "application/json" }
  
  def self.patch(endpoint, json_body)
    headers = { 'X-HTTP-Method-Override' => 'PATCH' }.merge(DEFAULT_HEADERS)
    response = post(endpoint, json_body, headers)
  end
  
  def self.post(endpoint, json_body, headers=DEFAULT_HEADERS)
    response = OAUTH_ACCESS_TOKEN.post(endpoint, json_body, headers)
  end
  
  def self.get(endpoint)
    response = OAUTH_ACCESS_TOKEN.get(endpoint)
    parsed_response = JSON.parse(response.body)
  end
  
  def self.all_labels
    parsed_response = get(LABELS_ENDPOINT)
  end
  
  def self.all_filters
    parsed_response = get(FILTERS_ENDPOINT)
  end
end