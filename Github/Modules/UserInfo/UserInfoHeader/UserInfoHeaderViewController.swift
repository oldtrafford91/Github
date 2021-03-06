import UIKit

class UserInfoHeaderViewController: UIViewController {
  // MARK: Properties
  var viewModel: UserRepresentable! {
    didSet { configure(with: viewModel) }
  }
  
  // MARK: - Views
  let avatarImageView = AvatarImageView()
  let usernameLabel = TitleLabel(textAlignment: .left, fontSize: 34)
  let nameLabel = SecondaryTitleLabel(fontSize: 18)
  let locationImageView = UIImageView()
  let locationLabel = SecondaryTitleLabel(fontSize: 18)
  let bioLabel = BodyLabel(textAlignment: .left)
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewHierachy()
  }
  // MARK: - Configure
  private func configureViewHierachy() {
    addSubviews()
    configureAvatarImageView()
    configureUsernameLabel()
    configureNameLabel()
    configureLocationLabel()
    configureLocationImageView()
    configureBioLabel()
  }
  
  private func addSubviews() {
    view.addSubview(avatarImageView)
    view.addSubview(usernameLabel)
    view.addSubview(nameLabel)
    view.addSubview(locationImageView)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
  }
  
  private func configureAvatarImageView() {
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      avatarImageView.widthAnchor.constraint(equalToConstant: 90),
      avatarImageView.heightAnchor.constraint(equalToConstant: 90),
    ])
  }
  
  private func configureUsernameLabel() {
    NSLayoutConstraint.activate([
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      usernameLabel.heightAnchor.constraint(equalToConstant: 38)
    ])
  }
  
  private func configureNameLabel() {
    NSLayoutConstraint.activate([
      nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  private func configureLocationImageView() {
    locationImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      locationImageView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
      locationImageView.widthAnchor.constraint(equalToConstant: 20),
      locationImageView.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  private func configureLocationLabel() {
    NSLayoutConstraint.activate([
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      locationLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  private func configureBioLabel() {
    bioLabel.numberOfLines = 3
    NSLayoutConstraint.activate([
      bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      bioLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func configure(with viewModel: UserRepresentable) {
    DispatchQueue.main.async {
      self.avatarImageView.setImage(with: viewModel.avatarURL)
      self.usernameLabel.text = viewModel.username
      self.nameLabel.text = viewModel.name
      self.locationImageView.image = viewModel.locationImage
      self.locationLabel.text = viewModel.location
      self.bioLabel.text = viewModel.bio
    }
  }
}

extension UserInfoHeaderViewController {
  private func calculatePreferredSize() {
      let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
      preferredContentSize = view.systemLayoutSizeFitting(targetSize)
  }
  
  override func viewDidLayoutSubviews() {
    calculatePreferredSize()
  }
}
