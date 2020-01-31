import UIKit

struct UserInfoHeaderViewModel {
  private let user: User
  
  init(user: User) {
    self.user = user
  }
  
  var avatarURL: URL {
    return user.avatarUrl
  }
  
  var username: String {
    return user.login
  }
  
  var name: String? {
    return user.name
  }
  
  var location: String? {
    return user.location
  }
  
  var locationImage: UIImage {
    return UIImage(systemName: "mappin.and.ellipse")!
  }
  
  var bio: String? {
    return user.bio
  }
}
