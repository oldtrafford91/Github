import UIKit

class BodyLabel: UILabel {
  
  //MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(textAlignment: NSTextAlignment) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Setup
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    font = UIFont.preferredFont(forTextStyle: .body)
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.75
    lineBreakMode = .byWordWrapping
  }
}
