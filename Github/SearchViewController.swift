import UIKit

class SearchViewController: UIViewController {
  
  //MARK: - View Life Cycle
  override func loadView() {
    view = SearchView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
}
