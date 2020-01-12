import Foundation

enum NetworkError: String, Error {
  case unknown = "Unknown error"
  case connectivity = "Unable to complete your request. Please check your internet connection."
  case invalidResponse = "Invalid response from server. Please try again."
  case invalidData = "The data received from server is invalid. Please try again."
}

class NetworkClient {
  
  //MARK: - Properties
  let session: URLSession
  
  //MARK: - Initializer
  static let shared = NetworkClient()
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  @discardableResult
  func get<T: Codable>(username: String, page: Int, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionTask {
    let followerURL = URL(string: "https://api.github.com/\(username)/followers")!
    let request = URLRequest(url: followerURL)
    
    let task = session.dataTask(with: request) { (data, response, error) in
      
      if let _ = error {
        completion(.failure(.connectivity))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
          completion(.failure(.invalidResponse))
          return
      }
      
      guard let data = data else {
        completion(.failure(.invalidData))
        return
      }
      
      do {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try jsonDecoder.decode(T.self, from: data)
        completion(.success(decoded))
      } catch {
        completion(.failure(.invalidData))
      }
    }
    return task
  }
}
