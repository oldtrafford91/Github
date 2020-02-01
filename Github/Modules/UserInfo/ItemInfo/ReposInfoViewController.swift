import UIKit

class ReposInfoViewController: ItemInfoViewController {
  override func configureButton() {
    actionButton.setTitle("Github Profile", for: .normal)
    actionButton.backgroundColor = .systemPurple
  }
  
  override func configure(with viewModel: UserRepresentable) {
    leftItemInfoView.configure(with: .repos, count: viewModel.publicRepos)
    rightItemInfoView.configure(with: .gist, count: viewModel.publicGists)
  }
}
