import UIKit

extension AvatarImageView {
  func setImage(with url: URL) {
    ImageDownloader.shared.downloadImage(from: url) { [weak self] image in
      guard let self = self, let image = image else { return }
      DispatchQueue.main.async {
        self.image = image
        self.alpha = 0
        UIView.animate(withDuration: 0.25) {
          self.alpha = 1
        }
      }
    }
  }
}
