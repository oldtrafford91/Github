import UIKit

class UserInfoViewController: UIViewController {
  // MARK: Properties
  var username: String!
  
  // MARK: Views
  let headerViewContainer = UIView()
  let headerVC = UserInfoHeaderViewController()
  let reposInfoViewContainer = UIView()
  let reposInfoVC = ReposInfoViewController()
  let followInfoViewContainer = UIView()
  let followInfoVC = FollowInfoViewController()
  
  // MARK: Constraints
  var headerViewHeightConstraint: NSLayoutConstraint!
  
  // MARK: Dependencies
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
    viewModel.onFetchedUser = { [weak self] user in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.headerVC.viewModel = self.viewModel
        self.followInfoVC.viewModel = self.viewModel
        self.reposInfoVC.viewModel = self.viewModel
      }
    }
    viewModel.onFetchedUserFailed = { [weak self] error in
      guard let self = self else { return }
      self.showAlertOnMainThread(title: "Something wrong", message: error.localizedDescription, buttonTitle: "OK")
    }
  }
  
  private func addSubviews() {
    view.addSubview(headerViewContainer)
    view.addSubview(reposInfoViewContainer)
    view.addSubview(followInfoViewContainer)
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
      followInfoViewContainer.heightAnchor.constraint(equalToConstant: 140)
    ])
  }
  
  // MARK: Event Handler
  @objc private func dismissVC() {
    dismiss(animated: true)
  }
  
  // MARK: Actions
  private func getUserInfo() {
    viewModel.getUserInfo(username: username)
  }
}

extension UserInfoViewController {
  override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
    super.preferredContentSizeDidChange(forChildContentContainer: container)
    if (container as? UserInfoHeaderViewController) != nil {
      headerViewHeightConstraint.constant = container.preferredContentSize.height
    }
  }
}
