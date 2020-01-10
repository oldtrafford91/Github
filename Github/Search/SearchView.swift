import UIKit

protocol SearchViewDelegate: class {
  func callToActionButtonDidPress()
  func texfieldReturnKeyDidPress()
}

class SearchView: UIView {
  //MARK: - Properties
  let logoImageView = UIImageView()
  let usernameTextField = UsernameTextField()
  let callToActionButton = RoundedButton(backgroundColor: .systemGreen, title: "Search Followers")
  weak var delegate: SearchViewDelegate?
  
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
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
    addGestureRecognizer(tapGesture)
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
    usernameTextField.delegate = self
    NSLayoutConstraint.activate([
      usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
      usernameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureCallToActionButton() {
    addSubview(callToActionButton)
    callToActionButton.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  @objc private func tapGestureHandler() {
    endEditing(true)
  }
  
  @objc private func handleButtonPress() {
    delegate?.callToActionButtonDidPress()
  }
}

extension SearchView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    delegate?.texfieldReturnKeyDidPress()
    endEditing(true)
    return true
  }
}
