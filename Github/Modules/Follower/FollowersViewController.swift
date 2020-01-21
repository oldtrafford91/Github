import UIKit

class FollowersViewController: UIViewController {
  enum Section {
    case main
  }
  
  // MARK: - Properties
  var username: String!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Follower>!
  
  // MARK: - Dependencies
  let viewModel = FollowersViewModel()
  
  // MARK: - Views
  var collectionView: UICollectionView!
  let loadingView = LoadingView()
  let refreshControl = UIRefreshControl()
  
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
    title = username
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    configureCollectionView()
    configureViewModelBinding()
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    collectionView.alwaysBounceVertical = true
    collectionView.refreshControl = refreshControl
    collectionView.refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
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
  
  private func configureViewModelBinding() {
    viewModel.onFetchedFollowers = { [weak self] followers in
      guard let self = self else { return }
      if followers.count == 0 {
        DispatchQueue.main.async {
          self.collectionView.showEmptyStateView(message: "This user don't have any followers. Go follow her/him")
        }
      }
      self.updateData(with: followers)
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
  
  // MARK: - Helpers
  private func getFollowers() {
    viewModel.getFollowers(of: username)
  }
  
  @objc private func reload() {
    viewModel.reload()
  }
  
  private func updateData(with followers: [Follower], animated: Bool = true) {
    currentSnapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    currentSnapshot.appendSections([.main])
    currentSnapshot.appendItems(followers, toSection: .main)
    dataSource.apply(currentSnapshot, animatingDifferences: animated)
  }
  
  private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    let itemSize = (width - (padding * 2) - (minimumItemSpacing * 2)) / 3
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = CGSize(width: itemSize, height: itemSize + 40)
    return layout
  }
}

// MARK: - UICollectionView Delegate
extension FollowersViewController: UICollectionViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentHeight = scrollView.contentSize.height
    let scrollViewHeight = scrollView.bounds.height
    let contentOffsetY = scrollView.contentOffset.y
    
    if contentOffsetY >= (contentHeight - scrollViewHeight) {
      getFollowers()
    }
  }
}
