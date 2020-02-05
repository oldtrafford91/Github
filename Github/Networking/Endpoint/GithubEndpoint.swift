import Foundation

enum GithubEndpoint: Endpoint {
  case getFollowers(username: String, limit: Int, page: Int)
  case getUserInfo(username: String)
}

extension GithubEndpoint {
  var baseURL: String {
    return "https://api.github.com"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var path: String {
    switch self {
    case .getFollowers(let username, _, _):
      return "/users/\(username)/followers"
    case .getUserInfo(let username):
      return "/users/\(username)"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .getFollowers( _, let limit, let page):
      return [
        URLQueryItem(name: "per_page", value: "\(limit)"),
        URLQueryItem(name: "page", value: "\(page)")
      ]
    case .getUserInfo(_):
      return []
    }
  }
  
  var url: URL? {
    var components = URLComponents()
    let baseURL = URL(string: self.baseURL)
    components.scheme = "https"
    components.host = baseURL?.host
    components.path = path
    components.queryItems = queryItems
    return components.url
  }
  
  var urlRequest: URLRequest? {
    guard let url = url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    return request
  }
}
