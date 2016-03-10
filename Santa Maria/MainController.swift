import UIKit

class MainController: UIViewController, UIPageViewControllerDataSource {
    private var index = 0
    private var pageViewController: UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        pageViewController!.dataSource = self
        let v = storyboard?.instantiateViewControllerWithIdentifier("PageViewContentController") as! PageViewContentController
        v.setIndex(0)
        pageViewController?.setViewControllers([v], direction: .Forward, animated: false, completion: nil)
        pageViewController?.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController?.didMoveToParentViewController(self)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if index == PageViewContentController.pageNumber - 1 {
            return nil
        } else {
            index--
            let view = storyboard?.instantiateViewControllerWithIdentifier("PageViewContentController") as! PageViewContentController
            view.setIndex(index)
            return view
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if index == 0 {
            return nil
        } else {
            index++
            let view = storyboard?.instantiateViewControllerWithIdentifier("PageViewContentController") as! PageViewContentController
            view.setIndex(index)
            return view
        }
    }
}