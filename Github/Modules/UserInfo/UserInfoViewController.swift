import UIKit

class UserInfoViewController: UIViewController {
  // MARK: Properties
  var username: String!
  
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
  }
  
  func configureNavigationBar() {
    title = username
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  func configureViewModelBinding() {
    viewModel.onFetchedUser = { [weak self] user in
      guard let self = self else { return }
      print(user)
    }
    viewModel.onFetchedUserFailed = { [weak self] error in
      print(error.localizedDescription)
    }
  }
  
  // MARK: Event Handler
  @objc private func dismissVC() {
    dismiss(animated: true)
  }
  
  // MARK: Actions
  func getUserInfo() {
    viewModel.getUserInfo(username: username)
  }
}
