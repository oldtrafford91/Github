import UIKit
import SafariServices

protocol UserInfoViewControllerDelegate: class {
  func userInfoViewControllerDidRequestFollowers(of username: String)
}

class UserInfoViewController: UIViewController {
  // MARK: - Properties
  var username: String!
  weak var delegate: UserInfoViewControllerDelegate?
  
  // MARK: - Views
  private let headerViewContainer = UIView()
  private let headerVC = UserInfoHeaderViewController()
  private let reposInfoViewContainer = UIView()
  private let reposInfoVC = ReposInfoViewController()
  private let followInfoViewContainer = UIView()
  private let followInfoVC = FollowInfoViewController()
  private let joinedDateLabel = BodyLabel(textAlignment: .center)
  
  // MARK: - Constraints
  private var headerViewHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Dependencies
  let viewModel = UserInfoViewModel()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewHierachy()
    configureViewModelBinding()
    getUserInfo()
  }
  
  // MARK: - Configure
  private func configureViewHierachy() {
    view.backgroundColor = .systemBackground
    addSubviews()
    configureNavigationBar()
    layoutUI()
  }
  
  private func configureNavigationBar() {
    title = username
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  private func configureViewModelBinding() {
    viewModel.onFetchedUser = { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.configure(with: self.viewModel)
      }
    }
    viewModel.onFetchedUserFailed = { [weak self] error in
      guard let self = self else { return }
      self.showAlert(title: "Something wrong", message: error.localizedDescription, buttonTitle: "OK")
    }
  }
  
  private func configure(with viewModel: UserRepresentable) {
    headerVC.viewModel = viewModel
    followInfoVC.viewModel = viewModel
    reposInfoVC.viewModel = viewModel
    joinedDateLabel.text = viewModel.joinedDate
    followInfoVC.delegate = self
    reposInfoVC.delegate = self
  }
  
  private func addSubviews() {
    view.addSubview(headerViewContainer)
    view.addSubview(reposInfoViewContainer)
    view.addSubview(followInfoViewContainer)
    view.addSubview(joinedDateLabel)
    add(headerVC, in: headerViewContainer)
    add(reposInfoVC, in: reposInfoViewContainer)
    add(followInfoVC, in: followInfoViewContainer)
  }
  
  private func layoutUI() {
    let padding: CGFloat = 20
    headerViewContainer.translatesAutoresizingMaskIntoConstraints = false
    headerViewHeightConstraint = headerViewContainer.heightAnchor.constraint(equalToConstant: 200)
    headerViewHeightConstraint.priority = .init(rawValue: 750)
    
    followInfoViewContainer.translatesAutoresizingMaskIntoConstraints = false
    reposInfoViewContainer.translatesAutoresizingMaskIntoConstraints = false
    joinedDateLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      headerViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      headerViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      headerViewContainer.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.25),
      headerViewHeightConstraint,
      
      reposInfoViewContainer.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor, constant: padding),
      reposInfoViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      reposInfoViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      reposInfoViewContainer.heightAnchor.constraint(equalToConstant: 140),
      
      followInfoViewContainer.topAnchor.constraint(equalTo: reposInfoViewContainer.bottomAnchor, constant: padding),
      followInfoViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      followInfoViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      followInfoViewContainer.heightAnchor.constraint(equalToConstant: 140),
      
      joinedDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      joinedDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      joinedDateLabel.topAnchor.constraint(equalTo: followInfoViewContainer.bottomAnchor, constant: padding),
      joinedDateLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
  
  // MARK: - Event Handler
  @objc private func dismissVC() {
    dismiss(animated: true)
  }
  
  // MARK: - Actions
  private func getUserInfo() {
    viewModel.getUserInfo(username: username)
  }
}

// MARK: -
extension UserInfoViewController {
  override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
    super.preferredContentSizeDidChange(forChildContentContainer: container)
    if (container as? UserInfoHeaderViewController) != nil {
      headerViewHeightConstraint.constant = container.preferredContentSize.height
    }
  }
}

extension UserInfoViewController: ReposInfoViewControllerDelegate {
  func reposInfoViewControllerDidTapGithubProfileButton(controller: ReposInfoViewController) {
    let safariVC = SFSafariViewController(url: controller.viewModel.profileURL)
    safariVC.preferredControlTintColor = .systemGreen
    present(safariVC, animated: true)
  }
}

extension UserInfoViewController: FollowInfoViewControllerDelegate {
  func followInfoViewControllerDidTapGetFollowersButton(controller: FollowInfoViewController) {
    delegate?.userInfoViewControllerDidRequestFollowers(of: controller.viewModel.username)
    dismiss(animated: true)
  }
}
