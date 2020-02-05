import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}

protocol Endpoint {
  var method: HTTPMethod { get }
  var baseURL: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
}
