import UIKit

class ImageDownloader {
  static let shared = ImageDownloader()
  let client: HTTPClient = URLSessionHTTPClient()
  let cache = ImageCache()
  
  func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: url.absoluteString)
    if let image = cache.loadImage(forKey: cacheKey) {
      completion(image)
      return
    }
    
    let imageRequest = URLRequest(url: url)
    client.request(imageRequest) { result in
      switch result {
      case .success(let imageData, let response):
        guard response.statusCode == 200 else {
          completion(nil)
          return
        }
        if let image = UIImage(data: imageData) {
          self.cache.save(image, withKey: cacheKey)
          completion(image)
        } else {
          completion(nil)
        }
      case .failure(_):
        completion(nil)
      }
    }
  }
}
