import UIKit
import Caravel
import WebKit
import Cent

class PageViewContentController: UIViewController {
    private static let pages = [
        "simple_event",
        "simple_event_explanation"
    ]

    static var pageNumber: Int {
        return pages.count
    }

    private var index: Int?
    private var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let i = self.index {
            let config = WKWebViewConfiguration()
            let webView = WKWebView(frame: view.frame, configuration: config)
            webView.scrollView.bounces = false
            webView.scrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            view.addSubview(webView)

            webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource(PageViewContentController.pages[i], withExtension: "html")!))
            self.webView = webView
        }
    }

    func setIndex(index: Int) {
        self.index = index
    }
}
