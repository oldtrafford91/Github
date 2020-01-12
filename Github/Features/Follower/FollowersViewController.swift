import UIKit

class FollowersViewController: UIViewController {
  
  //MARK: Properties
  var username: String!
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    NetworkClient.shared.get(username: username, page: 1) { [weak self] (result: Result<[Follower], NetworkError>) in
      guard let self = self else { return }
      switch result {
      case .success(let followers):
        print(followers)
      case .failure(let error):
        self.showAlertOnMainThread(title: "Badthing happen", message: error.rawValue, buttonTitle: "OK")
        print(error.rawValue)
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func configureUI() {
    title = username
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
