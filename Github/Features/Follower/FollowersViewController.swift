import UIKit

class FollowersViewController: UIViewController {
  
  //MARK: Properties
  var username: String!
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    NetworkClient.shared.get(username: username, page: 1) { (result: Result<[Follower], NetworkError>) in
      switch result {
      case .success(let followers):
        print(followers)
      case .failure(let error):
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