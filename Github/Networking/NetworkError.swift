import Foundation

enum NetworkError: String, Error {
  case unknown = "Unknown error"
  case connectivity = "Unable to complete your request. Please check your internet connection."
  case invalidResponse = "Invalid response from server. Please try again."
  case invalidData = "The data received from server is invalid. Please try again."
  case parsingError = "Eror passing data. Please check your model declaration"
}
