import UIKit

class MainController: UIViewController, UIPageViewControllerDataSource {
    private var currentPageIndex = 0
    private var pageViewController: UIPageViewController?

    private func getPage() -> PageViewContentController? {
        guard let s = storyboard else {
            return nil
        }

        guard let pageView = s.instantiateViewControllerWithIdentifier("PageViewContentController") as? PageViewContentController else {
            return nil
        }

        pageView.setIndex(currentPageIndex)
        return pageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let s = storyboard else {
            return
        }

        guard let pageViewController = s.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController else {
            // TODO fatalError
            return
        }

        pageViewController.dataSource = self

        guard let page = getPage() else {
            return
        }

        pageViewController.setViewControllers([page], direction: .Forward, animated: false, completion: nil)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        self.pageViewController = pageViewController
        pageViewController.didMoveToParentViewController(self)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if currentPageIndex == PageViewContentController.pageNumber - 1 {
            return nil
        } else {
            currentPageIndex++
            return getPage()
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if currentPageIndex == 0 {
            return nil
        } else {
            currentPageIndex--
            return getPage()
        }
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return PageViewContentController.pageNumber
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentPageIndex
    }
}