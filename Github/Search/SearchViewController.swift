import UIKit

class SearchViewController: UIViewController {
  
  //MARK: - View Life Cycle
  override func loadView() {
    let searchView = SearchView()
    searchView.delegate = self
    view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
}

extension SearchViewController: SearchViewDelegate {
  func texfieldReturnKeyDidPress() {
    pushFollowersViewController()
  }
  
  func callToActionButtonDidPress() {
    pushFollowersViewController()
  }
  
  func pushFollowersViewController() {
    navigationController?.pushViewController(FollowersViewController(), animated: true)
  }
}
