import UIKit

class FollowersViewController: UIViewController {
  enum Section {
    case main
  }
  
  //MARK: Properties
  var username: String!
  var followers: [Follower] = []
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Follower>!
  
  // MARK: - Views
  var collectionView: UICollectionView!
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureHierachy()
    configureDataSource()
    getFollowers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  // MARK: Setup
  private func configureHierachy() {
    title = username
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier)
    collectionView.backgroundColor = .systemBackground
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
  
  // MARK: - Helpers
  private func getFollowers() {
    NetworkClient.shared.get(username: username, page: 1) { [weak self] (result: Result<[Follower], NetworkError>) in
      guard let self = self else { return }
      switch result {
      case .success(let followers):
        print(followers)
        self.followers = followers
        self.updateUI(animated: true)
      case .failure(let error):
        self.showAlertOnMainThread(title: "Badthing happen", message: error.rawValue, buttonTitle: "OK")
        print(error.rawValue)
      }
    }
  }
  
  private func updateUI(animated: Bool = true) {
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
