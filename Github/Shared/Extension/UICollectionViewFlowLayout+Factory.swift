import UIKit

extension UICollectionViewFlowLayout {
  static func createCollectionViewLayout(in view: UIView, padding: CGFloat, minimumItemSpacing: CGFloat, numberOfColumn: Int) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let itemSize = (width - (padding * 2) - (minimumItemSpacing * 2)) / CGFloat(numberOfColumn)
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = CGSize(width: itemSize, height: itemSize + 40)
    return layout
  }

}
