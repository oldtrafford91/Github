import Foundation

class FollowerServices {
  private let client: HTTPClient
  
  init(client: HTTPClient) {
    self.client = client
  }
  
  func getFollowers(of user: String, limit: Int = 20, page: Int = 1, completion: @escaping (Result<[Follower], APIError>) -> Void) {
    let endpoint = FollowerEndpoint.getFollower(of: user, limit: limit, page: page)
    guard let urlRequest = endpoint.urlRequest else { return }
    client.request(urlRequest, completion: JSONMapper.map(completion: completion))
  }
}




