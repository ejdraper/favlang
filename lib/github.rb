require 'json'

class GitHub
  TOKEN = ENV["GITHUB_TOKEN"]
  ENDPOINT = "https://api.github.com/graphql"
  
  QUERY =<<EOF
query($username:String!, $cursor:String) {
  user(login: $username) {
    name
    repositories(first:100, after:$cursor) {
      nodes {
        name
        primaryLanguage {
          id
          name
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
}
EOF
  
  def self.get_repositories(username, cursor = nil)
    payload = {
      query: QUERY,
      variables: {
        username: username,
        cursor: cursor
      }
    }
    headers = {
      authorization: "Bearer #{TOKEN}"
    }
    response = RestClient.post(ENDPOINT, payload.to_json, headers)
    json = JSON.parse(response.body)
    raise json['errors'].map { |error| error['message'] }.join(", ") if json['errors']
    repos = json['data']['user']['repositories']
    page_info = repos['pageInfo']
    if page_info['hasNextPage']
      [repos['nodes'], get_repositories(username, page_info['endCursor'])].flatten
    else
      repos['nodes']
    end
  end
end