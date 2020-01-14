import Foundation

struct FollowerEndpoint: Endpoint {
  let baseURL: String
  let path: String
  let queryItems: [URLQueryItem]
}

extension FollowerEndpoint {
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

extension FollowerEndpoint {
  static func getFollower(of username: String, limit: Int = 10, page: Int = 1) -> FollowerEndpoint {
    return FollowerEndpoint(baseURL: "https://api.github.com", path: "/users/\(username)/followers",
              queryItems: [
                URLQueryItem(name: "per_page", value: "\(limit)"),
                URLQueryItem(name: "page", value: "\(page)")
              ])
  }
}


