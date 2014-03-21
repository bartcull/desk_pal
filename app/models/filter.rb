require 'desk_api'
class Filter
  def initialize
    @parsed_response = DeskApi.all_filters
  end
  
  def first_filter
    @parsed_response["_embedded"]["entries"].first
  end
  
  def first_filter_name
    first_filter['name']
  end
  
  def first_filter_cases_endpoint
    "#{DESK_SITE}#{first_filter["_links"]["cases"]["href"]}"
  end
end