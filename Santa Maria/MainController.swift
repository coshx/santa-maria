import UIKit

class MainController: UIViewController, UIPageViewControllerDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
}