import UIKit

class RoundedButton: UIButton {
  
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 10
    titleLabel?.textColor = .white
    titleLabel?.font = .preferredFont(forTextStyle: .headline)
  }
  
  
}
