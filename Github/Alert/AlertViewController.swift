import UIKit

class AlertViewController: UIViewController {
  
  //MARK: - Subviews
  let containerView = UIView()
  let titleLabel = TitleLabel(textAligment: .center, fontSize: 20)
  let messageLabel = BodyLabel(textAligment: .center)
  let actionButton = RoundedButton(backgroundColor: .systemPink, title: "OK")
  
  //MARK: - Properties
  var alertTitle: String?
  var message: String?
  var buttonTitle: String?
  
  let padding: CGFloat = 20.0
  
  //MARK: - Initializer
  init(alertTitle: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = alertTitle
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    configureContainerView()
    configureTitleLabel()
    configureActionButton()
    configureMessageLabel()
  }
  
  //MARK: - Setup
  private func configureContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  private func configureTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = title ?? "Something went wrong"
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
  
  private func configureActionButton() {
    containerView.addSubview(actionButton)
    actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
    actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  private func configureMessageLabel() {
    containerView.addSubview(messageLabel)
    messageLabel.text = message ?? ""
    messageLabel.numberOfLines = 0
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 8),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: -12),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
    ])
  }
  
  //MARK: - Actions
  @objc private func dismissViewController() {
    dismiss(animated: true, completion: nil)
  }
}
