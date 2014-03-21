DESK_SITE = 'https://cullimore.desk.com'
FILTERS_ENDPOINT ="#{DESK_SITE}/api/v2/filters"
CASES_ENDPOINT ="#{DESK_SITE}/api/v2/cases"
LABELS_ENDPOINT ="#{DESK_SITE}/api/v2/labels"

consumer = OAuth::Consumer.new(
        ENV['API_CONSUMER_KEY'],
        ENV['API_CONSUMER_SECRET'],
        :site => DESK_SITE,
        :scheme => :header
)

OAUTH_ACCESS_TOKEN = OAuth::AccessToken.from_hash(
        consumer,
        :oauth_token => ENV['DESK_ACCESS_TOKEN'],
        :oauth_token_secret => ENV['DESK_ACCESS_TOKEN_SECRET']
)
