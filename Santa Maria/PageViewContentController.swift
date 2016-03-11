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

    var index: Int?
    private var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let i = self.index else {
            fatalError()
        }

        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.frame, configuration: config)
        webView.scrollView.bounces = false
        view.addSubview(webView)

        webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource(PageViewContentController.pages[i], withExtension: "html")!))
        self.webView = webView
    }
}
