import UIKit

class FollowInfoViewController: ItemInfoViewController {
  override func configureButton() {
    actionButton.setTitle("Github Profile", for: .normal)
    actionButton.backgroundColor = .systemGreen
  }
  
  override func configure(with viewModel: UserRepresentable) {
    leftItemInfoView.configure(with: .follower, count: viewModel.followers)
    rightItemInfoView.configure(with: .following, count: viewModel.following)
  }
}

