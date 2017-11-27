

import UIKit

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
  //  If there are multiple storyboards in the project, each one must be named here:
  enum Storyboard: String {
    case main = "Main"
  }
  
  convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
    self.init(name: storyboard.rawValue, bundle: bundle)
  }
  
  class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
  }
  
  func instantiateViewController<T: UIViewController>() -> T {
    guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("Could not find view controller with name \(T.storyboardIdentifier)")
    }
    
    return viewController
  }
}
