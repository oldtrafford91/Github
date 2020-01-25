import Foundation

class UserInfoViewModel {
  typealias Observer<T> = (T) -> Void
  
  // MARK: Dependencies
  let userServices = UserServices(client: URLSessionHTTPClient())
  
  // MARK: Properties
  private var user: User? {
    didSet {
      guard let user = user else { return }
      onFetchedUser(user)
    }
  }
  
  var onFetchedUser: Observer<User> = { _ in }
  var onFetchedUserFailed: Observer<Error> = { _ in }
  
  // MARK: Actions
  func getUserInfo(username: String) {
    userServices.getUserInfo(of: username) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let user):
        self.user = user
      case .failure(let error):
        self.onFetchedUserFailed(error)
      }
    }
  }
  
}
