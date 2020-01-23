import UIKit

class UserInfoViewController: UIViewController {
  var username: String!
  override func viewDidLoad() {
    super.viewDidLoad()
    title = username
    view.backgroundColor = .systemBackground
  }
  
}
