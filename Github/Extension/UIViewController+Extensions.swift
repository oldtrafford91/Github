import UIKit

extension UIViewController {
  func showAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertViewController = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
      alertViewController.modalPresentationStyle = .fullScreen
      alertViewController.modalTransitionStyle = .crossDissolve
      self.present(alertViewController, animated: true, completion: nil)
    }
  }
}
