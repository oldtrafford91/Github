import UIKit

class ItemInfoViewController: UIViewController {
  // MARK: Properties
  var viewModel: UserRepresentable! {
    didSet { configure(with: viewModel) }
  }
  
  // MARK: Subviews
  let stackView = UIStackView()
  let leftItemInfoView = ItemInfoView()
  let rightItemInfoView = ItemInfoView()
  let actionButton = RoundedButton()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewHierachy()
  }
  
  // MARK: - Configure
  private func configureViewHierachy() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
    addSubviews()
    configureStackView()
    configureButton()
    layoutUI()
  }
  
  private func configureStackView() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
  }
  
  func configureButton() {
    preconditionFailure("Please configure button on subclass")
  }
  
  func configure(with viewModel: UserRepresentable) {
    preconditionFailure("Implement in subclass")
  }
  
  private func addSubviews() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(leftItemInfoView)
    stackView.addArrangedSubview(rightItemInfoView)
    view.addSubview(actionButton)
  }
  
  private func layoutUI() {
    let padding: CGFloat = 20
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      actionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
      actionButton.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
