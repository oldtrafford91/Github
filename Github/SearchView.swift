import UIKit

class SearchView: UIView {
  //MARK: - Properties
  let logoImageView = UIImageView()
  let usernameTextField = UsernameTextField()
  let callToActionButton = RoundedButton(backgroundColor: .systemGreen, title: "Search Followers")
  
  //MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Setup
  
  private func setupView() {
    backgroundColor = .systemBackground
    configureLogoImageView()
    configureUsernameTextField()
    configureCallToActionButton()
  }
  
  //MARK: - Helper
  private func configureLogoImageView() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(logoImageView)
    logoImageView.image = #imageLiteral(resourceName: "gh-logo")
    NSLayoutConstraint.activate([
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50)
    ])
  }
  
  private func configureUsernameTextField() {
    addSubview(usernameTextField)
    NSLayoutConstraint.activate([
      usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
      usernameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureCallToActionButton() {
    addSubview(callToActionButton)
    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
