import UIKit

class SlideshowController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!

    private var pageViewController: UIPageViewController?
    private var pageViewContentController: PageViewContentController?

    private func getPage(index: Int) -> PageViewContentController? {
        guard let s = storyboard else {
            return nil
        }

        guard let pageView = s.instantiateViewControllerWithIdentifier("PageViewContentController") as? PageViewContentController else {
            fatalError()
        }

        pageView.index = index

        return pageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let s = storyboard else {
            fatalError()
        }

        guard let pageViewController = s.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController else {
            fatalError()
        }

        pageViewController.dataSource = self

        guard let page = getPage(0) else {
            fatalError()
        }

        let y = navigationBar.frame.maxY

        pageViewController.setViewControllers([page], direction: .Forward, animated: false, completion: nil)
        pageViewController.view.frame = CGRect(x: 0, y: y, width: view.frame.size.width, height: view.frame.size.height - y)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        self.pageViewController = pageViewController
        pageViewController.didMoveToParentViewController(self)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let view = viewController as? PageViewContentController else {
            fatalError()
        }

        guard let index = view.index else {
            fatalError()
        }

        if index >= PageViewContentController.pageNumber - 1 {
            return nil
        } else {
            return getPage(index + 1)
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let view = viewController as? PageViewContentController else {
            fatalError()
        }

        guard let index = view.index else {
            fatalError()
        }

        if index <= 0 {
            return nil
        } else {
            return getPage(index - 1)
        }
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return PageViewContentController.pageNumber
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    @IBAction func onBackClicked(sender: AnyObject) {
        performSegueWithIdentifier(R.segue.exitSlideshow, sender: self)
    }
}