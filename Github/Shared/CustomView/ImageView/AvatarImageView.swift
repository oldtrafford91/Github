import UIKit

class AvatarImageView: UIImageView {
  let placeholderImage = #imageLiteral(resourceName: "avatar-placeholder")
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    image = placeholderImage
    layer.cornerRadius = 10
    layer.masksToBounds = true
    
  }
}
