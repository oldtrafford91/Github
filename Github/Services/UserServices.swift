import Foundation

class UserServices {
  private let client: HTTPClient
  
  init(client: HTTPClient) {
    self.client = client
  }
  
  func getUserInfo(of user: String, completion: @escaping (Result<User, APIError>) -> Void) {
    let endpoint = GithubEndpoint.getUserInfo(of: user)
    guard let urlRequest = endpoint.urlRequest else { return }
    client.request(urlRequest, completion: JSONMapper.map(completion: completion))
  }
}
