import Foundation

class FollowersViewModel {
  typealias Observer<T> = (T) -> ()
  // MARK: - Dependencies
  let followerServices = FollowerServices(client: URLSessionHTTPClient())
  
  // MARK: - Properties
  private var followers: [Follower] = [] {
    didSet {
      onFetchedFollowers(followers)
    }
  }

  var onFetchedFollowers: Observer<[Follower]> = { _ in }
  var onFetchFollowersFailed: Observer<APIError> = { _ in }
  
  // MARK: - Actions
  func getFollowers(of username: String) {
    followerServices.getFollowers(of: username) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let followers):
        print(followers)
        self.followers = followers
      case .failure(let error):
        self.onFetchFollowersFailed(error)
      }
    }
  }
}
