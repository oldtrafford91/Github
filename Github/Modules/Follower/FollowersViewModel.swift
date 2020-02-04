import UIKit

class FollowersViewModel {
  typealias Observer<T> = (T) -> ()
  // MARK: - Dependencies
  let followerServices = FollowerServices(client: URLSessionHTTPClient())
  
  // MARK: - Properties
  var username: String = "" { didSet { onUsernameChanged(username) } }
  private var filteredFollowers: [Follower] = []
  private var followers: [Follower] = [] { didSet { onFetchedFollowers(followers) } }
  private var isFiltering: Bool = false
  private var nextPage: Int = 1
  private var limit: Int = 20
  private var hasMore: Bool = true
  private var isLoading: Bool = false { didSet { onLoading(isLoading) } }
  
  var onUsernameChanged: Observer<String> = { _ in }
  var onFilterFollowers: Observer<[Follower]> = { _ in }
  var onFetchedFollowers: Observer<[Follower]> = { _ in }
  var onFetchFollowersFailed: Observer<APIError> = { _ in }
  var onLoading: Observer<Bool> = { _ in }
  
  // MARK: - Networking
  func getFollowers(of username: String) {
    if username != self.username {
      self.username = username
    }
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
  
  func reloadData(of username: String) {
    if username != self.username {
      self.username = username
    }
    self.nextPage = 1
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
  
  // MARK: - Filter
  func filterUser(using filter: String) {
    isFiltering = true
    if filter.count == 0 {
      filteredFollowers = followers
    } else {
      filteredFollowers = followers.filter {
        $0.login.lowercased().contains(filter.lowercased())
      }
    }
    onFilterFollowers(filteredFollowers)
  }
  
  func cancelFiltering() {
    isFiltering = false
  }
  
  func followerAt(indexPath: IndexPath) -> Follower {
    return isFiltering ? filteredFollowers[indexPath.row] : followers[indexPath.row]
  }
}
