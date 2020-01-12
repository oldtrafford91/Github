import UIKit

class AvatarImageView: UIImageView {
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func configure() {
    layer.cornerRadius = 10
    layer.masksToBounds = true
  }
}
