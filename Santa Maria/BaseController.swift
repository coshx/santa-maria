import UIKit
import WebKit
import Caravel

class BaseController: UIViewController {
    private(set) var webView: WKWebView?
    private(set) var webViewConfig: WKWebViewConfiguration?
    private(set) var bus: EventBus?

    private var exitSegueIdentifier: String?

    var headerColor: UIColor {
        return UIColor.whiteColor()
    }

    func whenBusReady() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func loadPage(file: String, busName: String) {
        loadPage(file, busName: busName, exitSegueIdentifier: nil)
    }

    func loadPage(file: String, busName: String, exitSegueIdentifier: String?) {
        self.exitSegueIdentifier = exitSegueIdentifier

        let config = WKWebViewConfiguration()
        let draftForMainBus = Caravel.getDraft(config)

        self.webViewConfig = config

        let frame = CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 20)

        let webView = WKWebView(frame: frame, configuration: config)
        self.webView = webView

        Caravel.get(self, name: busName, wkWebView: webView, draft: draftForMainBus, whenReady: { bus in
            self.bus = bus
            self.whenBusReady()
        })

        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.clearColor()

        view.backgroundColor = headerColor
        view.addSubview(webView)

        webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource(file, withExtension: "html")!))

        let panDown = UIPanGestureRecognizer(target: self, action: "onPanDown:")

        view.addGestureRecognizer(panDown)
    }

    func onPanDown(sender: UIPanGestureRecognizer) {
        guard let segueID = exitSegueIdentifier else {
            return
        }

        if sender.state == .Ended {
            let distance = sender.translationInView(view).y
            if distance > 180 {
                bus?.unregister()
                bus = nil
                webView = nil
                performSegueWithIdentifier(segueID, sender: self)
            }
        }
    }
}