import UIKit

class UserInfoViewModel {
  typealias Observer<T> = (T) -> Void
  
  // MARK: Dependencies
  let userServices = UserServices(client: URLSessionHTTPClient())
  
  // MARK: Properties
  private var user: User! {
    didSet { onFetchedUser(user) }
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

protocol UserRepresentable {
  var avatarURL: URL { get}
  var username: String { get }
  var name: String? { get }
  var location: String? { get }
  var locationImage: UIImage { get }
  var bio: String? { get }
  var publicRepos: Int { get }
  var publicGists: Int { get }
  var followers: Int { get }
  var following: Int { get }
  var joinedDate: String { get }
  var profileURL: URL { get }
}

extension UserInfoViewModel: UserRepresentable {
  var avatarURL: URL { return user.avatarUrl }
  var username: String { return user.login }
  var name: String? { return user.name }
  var location: String? { return user.location }
  var locationImage: UIImage { return UIImage(systemName: "mappin.and.ellipse")!}
  var bio: String? { return user.bio }
  var publicRepos: Int { return user.publicRepos }
  var publicGists: Int { return user.publicGists }
  var followers: Int { return user.followers }
  var following: Int { return user.following }
  var joinedDate: String {
    return "Joined Github since " + user.createdAt.convertToMonthYearFormat()
  }
  var profileURL: URL { return user.htmlUrl }
}
