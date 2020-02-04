import UIKit

protocol ReposInfoViewControllerDelegate: class {
  func reposInfoViewControllerDidTapGithubProfileButton(controller: ReposInfoViewController)
}

final class ReposInfoViewController: ItemInfoViewController {
  // MARK: Properties
  weak var delegate: ReposInfoViewControllerDelegate?
  
  // MARK: - Override
  override func configureButton() {
    actionButton.setTitle("Github Profile", for: .normal)
    actionButton.backgroundColor = .systemPurple
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
  }
  
  override func configure(with viewModel: UserRepresentable) {
    leftItemInfoView.configure(with: .repos, count: viewModel.publicRepos)
    rightItemInfoView.configure(with: .gist, count: viewModel.publicGists)
  }
  
  // MARK: - Event Handlers
  @objc private func actionButtonTapped() {
    delegate?.reposInfoViewControllerDidTapGithubProfileButton(controller: self)
  }
}
