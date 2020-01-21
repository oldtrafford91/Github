import UIKit

extension UICollectionView {
  func showEmptyStateView(message: String) {
    let emptyView = EmptyStateView(message: message)
    backgroundView = emptyView
  }
  
  func hideEmptyStateView() {
    backgroundView = nil
  }
}
