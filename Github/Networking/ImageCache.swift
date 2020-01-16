import UIKit

class ImageCache {
  let cache: NSCache<NSString, UIImage> = NSCache()
  
  func save(_ image: UIImage, withKey key: NSString) {
    cache.setObject(image, forKey: key)
  }
  
  func loadImage(forKey key: NSString) -> UIImage? {
    return cache.object(forKey: key)
  }
}
