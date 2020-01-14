import Foundation

protocol HTTPClient {
  func request(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), APIError>) -> Void) -> URLSessionTask
}

class URLSessionHTTPClient: HTTPClient {
  
  //MARK: - Properties
  let session: URLSession
  
  //MARK: - Initializer
  static let shared = URLSessionHTTPClient()
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  @discardableResult
  func request(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), APIError>) -> Void) -> URLSessionTask {
    let task = session.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        completion(.failure(.networkingError(error)))
      } else if let data = data, let response = response as? HTTPURLResponse {
        completion(.success((data, response)))
      }
    }
    task.resume()
    return task
  }
}
