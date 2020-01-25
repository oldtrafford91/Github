import Foundation

struct GithubEndpoint: Endpoint {
  let baseURL: String = "https://api.github.com"
  let path: String
  let queryItems: [URLQueryItem]
}

extension GithubEndpoint {
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
    return URLRequest(url: url)
  }
}

extension GithubEndpoint {
  static func getFollower(of username: String, limit: Int = 10, page: Int = 1) -> GithubEndpoint {
    return GithubEndpoint(path: "/users/\(username)/followers",
              queryItems: [
                URLQueryItem(name: "per_page", value: "\(limit)"),
                URLQueryItem(name: "page", value: "\(page)")
              ])
  }
  
  static func getUserInfo(of username: String) -> GithubEndpoint {
    return GithubEndpoint(path: "/users/\(username)", queryItems: [])
  }
}


