import UIKit

class LoadingView: UIView {
  // MARK: - Properties
  private weak var targetView: UIView?
  private let containerView =  UIView()
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  private func configure() {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0
    containerView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])
  }
  
  // MARK: - Showing
  func showInView(_ view: UIView) {
    targetView = view
    guard let targetView = targetView else { return }
    self.frame = targetView.bounds
    targetView.addSubview(self)
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: targetView.topAnchor),
      bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
      leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
      trailingAnchor.constraint(equalTo: targetView.trailingAnchor)
    ])
    UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
    activityIndicator.startAnimating()
  }

  // MARK: - Dismissing
  func dismiss() {
    activityIndicator.stopAnimating()
    removeFromSuperview()
  }
}


