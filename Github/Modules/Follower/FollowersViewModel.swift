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
  private var currentPage: Int = 1
  private var hasMore: Bool = true
  private var isLoading: Bool = false {
    didSet {
      onLoading(isLoading)
    }
  }
  
  var onFetchedFollowers: Observer<[Follower]> = { _ in }
  var onFetchFollowersFailed: Observer<APIError> = { _ in }
  var onLoading: Observer<Bool> = { _ in }
  
  // MARK: - Actions
  func getFollowers(of username: String) {
    guard hasMore && isLoading == false else { return }
    isLoading = true
    followerServices.getFollowers(of: username, limit: 20, page: currentPage) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      switch result {
      case .success(let followers):
        if followers.count < 20 {
          self.hasMore = false
        }
        self.currentPage += 1
        self.followers.append(contentsOf: followers)
      case .failure(let error):
        self.onFetchFollowersFailed(error)
      }
    }
  }
}
