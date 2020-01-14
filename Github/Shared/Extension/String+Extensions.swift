import Foundation

extension String {
  func isValidGithubUsername() -> Bool {
    let usernameFormat = "/^[a-z\\d](?:[a-z\\d]|-(?=[a-z\\d])){0,38}$/i"
    let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameFormat)
    return usernamePredicate.evaluate(with: self)
  }
}
