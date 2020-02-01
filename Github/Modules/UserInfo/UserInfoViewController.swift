import UIKit

class UserInfoViewController: UIViewController {
  // MARK: Properties
  var username: String!
  
  // MARK: Views
  let headerViewContainer = UIView()
  let headerVC = UserInfoHeaderViewController()
  let reposInfoViewContainer = UIView()
  
  let followInfoViewContainer = UIView()
  
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
    configureNavigationBar()
    configureHeaderView()
  }
  
  private func configureNavigationBar() {
    title = username
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  private func configureHeaderView() {
    headerViewContainer.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(headerViewContainer)

    headerViewHeightConstraint = headerViewContainer.heightAnchor.constraint(equalToConstant: 200)
    headerViewHeightConstraint.priority = .init(rawValue: 750)
    NSLayoutConstraint.activate([
      headerViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      headerViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      headerViewContainer.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.25),
      headerViewHeightConstraint
    ])
    add(headerVC, in: headerViewContainer)
  }
  
  private func configureReposInfoViewContainer() {
    
  }
  
  private func configureFollowInfoViewContainer() {
    
  }
  
  private func configureViewModelBinding() {
    viewModel.onFetchedUser = { [weak self] user in
      guard let self = self else { return }
      self.headerVC.viewModel = UserInfoHeaderViewModel(user: user)
    }
    viewModel.onFetchedUserFailed = { [weak self] error in
      guard let self = self else { return }
      self.showAlertOnMainThread(title: "Something wrong", message: error.localizedDescription, buttonTitle: "OK")
    }
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
