import UIKit

class SecondaryTitleLabel: UILabel {
  
  //MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(fontSize: CGFloat) {
    self.init(frame: .zero)
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Setup
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
  }
}
