import UIKit

enum ItemInfoType {
  case repos
  case gist
  case following
  case follower
}

class ItemInfoView: UIView {
  // MARK: - Subviews
  let itemImageView = UIImageView()
  let itemLabel = TitleLabel(textAlignment: .left, fontSize: 14)
  let countLabel = TitleLabel(textAlignment: .center, fontSize: 14)
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(itemType: ItemInfoType) {
    self.init(frame: .zero)
    configure(with: itemType, count: 1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  private func configure() {
    addSubview(itemImageView)
    addSubview(itemLabel)
    addSubview(countLabel)
    
    itemImageView.translatesAutoresizingMaskIntoConstraints = false
    itemImageView.contentMode = .scaleAspectFill
    itemImageView.tintColor = .label
    
    NSLayoutConstraint.activate([
      itemImageView.topAnchor.constraint(equalTo: topAnchor),
      itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      itemImageView.widthAnchor.constraint(equalToConstant: 20),
      itemImageView.heightAnchor.constraint(equalToConstant: 20),
      
      itemLabel.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),
      itemLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
      itemLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      itemLabel.heightAnchor.constraint(equalToConstant: 18),
      
      countLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
  
  func configure(with type: ItemInfoType, count: Int) {
    switch type {
    case .follower:
      itemImageView.image = UIImage(systemName: "heart")
      itemLabel.text = "Followers"
    case .following:
      itemImageView.image = UIImage(systemName: "person.2")
      itemLabel.text = "Following"
    case .repos:
      itemImageView.image = UIImage(systemName: "folder")
      itemLabel.text = "Public Repos"
    case .gist:
      itemImageView.image = UIImage(systemName: "text.alignleft")
      itemLabel.text = "Public Gists"
    }
    countLabel.text = String(count)
  }
}
