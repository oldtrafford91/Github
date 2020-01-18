import Foundation

class JSONMapper<T: Codable> {
  
  @discardableResult
  static func map(completion: @escaping (Result<T, APIError>) -> Void) -> (Result<(Data, HTTPURLResponse), APIError>) -> Void {
    return { result in
      switch result {
      case .success(let data, let response):
        switch response.statusCode {
        case 200:
          do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            jsonDecoder.dateDecodingStrategy = .iso8601
            let object = try jsonDecoder.decode(T.self, from: data)
            completion(.success(object))
          } catch let decodingError as DecodingError {
            completion(.failure(.decodingError(decodingError)))
          } catch {
            preconditionFailure("Unhandled error: \(error.localizedDescription)")
          }
//        case 403:
//          print(response.value(forHTTPHeaderField: "X-RateLimit-Reset"))
//          completion(.failure(.requestError(403, "API rate limit exceeded")))
        case 404:
          completion(.failure(.requestError(404, "User don't exist")))
        case (400...499):
          let body = String(data: data, encoding: .utf8)
          completion(.failure(.requestError(response.statusCode, body ?? "<no body>")))
        case 500...599:
          completion(.failure(.serverError))
        default:
          preconditionFailure("Unhandled HTTP status code: \(response.statusCode)")
        }
      case .failure(let error):
        completion(.failure(error))
      } 
    }
  }
}
