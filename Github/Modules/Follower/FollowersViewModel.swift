import Foundation

class FollowersViewModel {
  typealias Observer<T> = (T) -> ()
  // MARK: - Dependencies
  let followerServices = FollowerServices(client: URLSessionHTTPClient())
  
  // MARK: - Properties
  private var username: String = ""
  private var followers: [Follower] = [] {
    didSet {
      onFetchedFollowers(followers)
    }
  }
  private var nextPage: Int = 1
  private var limit: Int = 20
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
    self.username = username
    guard hasMore && isLoading == false else { return }
    isLoading = true
    followerServices.getFollowers(of: username, limit: limit, page: nextPage) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      switch result {
      case .success(let followers):
        if followers.count < self.limit {
          self.hasMore = false
        }
        self.nextPage += 1
        self.followers.append(contentsOf: followers)
      case .failure(let error):
        self.onFetchFollowersFailed(error)
      }
    }
  }
  
  func reload() {
    followerServices.getFollowers(of: username, limit: limit, page: 1) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      switch result {
      case .success(let followers):
        switch followers.count {
        case 0..<self.limit:
          self.hasMore = false
          self.nextPage = 1
        default:
          self.nextPage = 2
        }
        self.followers = followers
      case .failure(let error):
        self.onFetchFollowersFailed(error)
      }
    }
  }
}
