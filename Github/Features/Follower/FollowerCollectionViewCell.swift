import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
  
  // MARK: Properties
  static let reuseIdentifier = "FollowerCollectionViewCell"
  
  // MARK: - Subviews
  let avatarImageView = AvatarImageView(frame: .zero)
  let usernameLabel = TitleLabel(textAlignment: .center, fontSize: 16)
  
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
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    let padding: CGFloat = 8
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
      
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  func configure(with follower: Follower) {
    self.usernameLabel.text = follower.login
  }
}
