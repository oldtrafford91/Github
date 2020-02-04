import UIKit

protocol FollowInfoViewControllerDelegate: class {
  func followInfoViewControllerDidTapGetFollowersButton(controller: FollowInfoViewController)
}

final class FollowInfoViewController: ItemInfoViewController {
  // MARK: - Properties
  weak var delegate: FollowInfoViewControllerDelegate?
  
  override func configureButton() {
    actionButton.setTitle("Get Followers", for: .normal)
    actionButton.backgroundColor = .systemGreen
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
  }
  
  override func configure(with viewModel: UserRepresentable) {
    leftItemInfoView.configure(with: .follower, count: viewModel.followers)
    rightItemInfoView.configure(with: .following, count: viewModel.following)
  }
  
  // MARK: - Event Handlers
  @objc private func actionButtonTapped() {
    delegate?.followInfoViewControllerDidTapGetFollowersButton(controller: self)
  }
}
