import UIKit

class FollowersViewController: UIViewController {
  enum Section {
    case main
  }
  
  // MARK: - Properties
  var username: String! { didSet { viewModel.username = username } }
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Follower>!
  
  // MARK: - Dependencies
  lazy var viewModel: FollowersViewModel = {
    let viewModel = FollowersViewModel()
    return viewModel
  }()
  
  // MARK: - Views
  var collectionView: UICollectionView!
  let loadingView = LoadingView()
  let refreshControl = UIRefreshControl()
  let searchController = UISearchController()
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureHierachy()
    getFollowers()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  // MARK: - Setup
  private func configureHierachy() {
    title = viewModel.username
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    configureCollectionView()
    configureSearchController()
    configureViewModelBinding()
  }
  
  private func configureCollectionView() {
    let threeComlumnsFlowLayout = UICollectionViewFlowLayout.createCollectionViewLayout(in: view, padding: 12, minimumItemSpacing: 10, numberOfColumn: 3)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: threeComlumnsFlowLayout)
    collectionView.alwaysBounceVertical = true
    collectionView.refreshControl = refreshControl
    collectionView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier)
    collectionView.backgroundColor = .systemBackground
    collectionView.delegate = self
    configureDataSource()
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
      guard let followerCell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier, for: indexPath) as? FollowerCollectionViewCell else { fatalError("Can't create cell") }
      followerCell.configure(with: follower)
      return followerCell
    })
  }
  
  private func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Please enter an user name"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }
  
  private func configureViewModelBinding() {
    viewModel.onUsernameChanged = { [weak self] username in
      guard let self = self else { return }
      self.title = username
      self.collectionView.setContentOffset(.zero, animated: true)
    }
    viewModel.onFetchedFollowers = { [weak self] followers in
      guard let self = self else { return }
      if followers.count == 0 {
        DispatchQueue.main.async {
          self.collectionView.showEmptyStateView(message: "This user don't have any followers. Go follow her/him")
        }
      }
      self.updateData(with: followers)
    }
    viewModel.onFilterFollowers = { [weak self] filteredFollowers in
      guard let self = self else { return }
      self.updateData(with: filteredFollowers)
    }
    viewModel.onFetchFollowersFailed = { [weak self] error in
      guard let self = self else { return }
      self.showAlertOnMainThread(title: "Something wrong", message: error.localizedDescription, buttonTitle: "OK")
    }
    viewModel.onLoading = { [weak self] isLoading in
      guard let self = self else { return }
      if isLoading {
        DispatchQueue.main.async { self.loadingView.showInView(self.view) }
      } else {
        DispatchQueue.main.async {
          self.refreshControl.endRefreshing()
          self.loadingView.dismiss()
        }
      }
    }
  }
  
  // MARK: - Actions
  private func getFollowers() {
    viewModel.getFollowers(of: viewModel.username)
  }
  
  @objc private func reloadData() {
    viewModel.reloadData(of: viewModel.username)
  }
  
  private func updateData(with followers: [Follower], animated: Bool = true) {
    currentSnapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    currentSnapshot.appendSections([.main])
    currentSnapshot.appendItems(followers, toSection: .main)
    dataSource.apply(currentSnapshot, animatingDifferences: animated)
  }
}

// MARK: - UICollectionView Delegate
extension FollowersViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let follower = viewModel.followerAt(indexPath: indexPath)
    
    let userInfoVC = UserInfoViewController()
    userInfoVC.username = follower.login
    userInfoVC.delegate = self
    let userInfoNC = UINavigationController(rootViewController: userInfoVC)
    show(userInfoNC, sender: self)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let contentHeight = scrollView.contentSize.height
    let scrollViewHeight = scrollView.bounds.height
    let contentOffsetY = scrollView.contentOffset.y
    
    if contentOffsetY >= (contentHeight - scrollViewHeight) {
      getFollowers()
    }
  }
}

// MARK: - UISearchResultsUpdating
extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text else {
      return
    }
    viewModel.filterUser(using: filter)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.cancelFiltering()
  }
}

// MARK: - UserInfoViewControllerDelegate
extension FollowersViewController: UserInfoViewControllerDelegate {
  func userInfoViewControllerDidRequestFollowers(of username: String) {
    self.username = username
    reloadData()
  }
}
