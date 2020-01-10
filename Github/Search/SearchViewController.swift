import UIKit

class SearchViewController: UIViewController {

  //MARK: Outlets
  unowned var searchView: SearchView { return self.view as! SearchView }
  unowned var logoImageView: UIImageView { return searchView.logoImageView }
  unowned var usernameTextField: UsernameTextField { return searchView.usernameTextField }
  unowned var callToActionButton: RoundedButton { return searchView.callToActionButton }
  
  //MARK: - View Life Cycle
  override func loadView() {
    let searchView = SearchView()
    view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameTextField.delegate = self
    callToActionButton.addTarget(self, action: #selector(callToActionButtonPressed), for: .touchUpInside)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
    view.addGestureRecognizer(tapGesture)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  //MARK: - Actions
  @objc private func tapGestureHandler() {
    view.endEditing(true)
  }
  
  @objc func callToActionButtonPressed() {
    pushFollowersViewController()
  }
  
  //MARK: - Helpers
  func pushFollowersViewController() {
    navigationController?.pushViewController(FollowersViewController(), animated: true)
  }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    pushFollowersViewController()
    return true
  }
}
