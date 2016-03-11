import UIKit
import Caravel
import WebKit
import Cent
import Caravel

class PageViewContentController: UIViewController {
    private static let pages: [(String, ICaravelPage?)] = [
        ("simple_event", SimpleEventCaravel()),
        ("simple_event_explanation", nil),
        ("multiple_subscribers", MultipleSubscribersCaravel())
    ]

    static var pageNumber: Int {
        return pages.count
    }

    var index: Int?
    private var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let i = self.index else {
            fatalError()
        }

        let config = WKWebViewConfiguration()
        let draft = Caravel.getDraft(config)
        let webView = WKWebView(frame: view.frame, configuration: config)
        webView.scrollView.bounces = false
        view.addSubview(webView)

        if let caravelPage = PageViewContentController.pages[i].1 {
            caravelPage.setDraft(webView, draft: draft)
        }

        webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource(PageViewContentController.pages[i].0, withExtension: "html")!))
        self.webView = webView
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if let i = index {
            if let caravelPage = PageViewContentController.pages[i].1 {
                caravelPage.isMovingToAnotherPage()
            }
        }
    }
}
