import UIKit

class UserInfoViewController: UIViewController {
  // MARK: Properties
  var username: String!
  
  // MARK: Views
  let headerView = UIView()
  let headerVC = UserInfoHeaderViewController()
  
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
    headerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(headerView)

    headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 200)
    headerViewHeightConstraint.priority = .init(rawValue: 750)
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      headerView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.25),
      headerViewHeightConstraint
    ])
    add(headerVC, in: headerView)
  }
  
  private func configureViewModelBinding() {
    viewModel.onFetchedUser = { [weak self] user in
      guard let self = self else { return }
      self.headerVC.user = user
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
