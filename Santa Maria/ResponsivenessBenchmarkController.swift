import UIKit
import WebKit
import Caravel
import SwiftyTimer

class ResponsivenessBenchmarkController: UIViewController {
    private var webView: WKWebView?

    private var bus: EventBus?
    private var timer: NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        let draft = Caravel.getDraft(config)

        let webView = WKWebView(frame: view.frame, configuration: config)
        self.webView = webView

        Caravel.get(self, name: "ResponsivenessBenchmark", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus = bus

            bus.registerOnMain("EventNumber") { name, data in
                let n = data as! Int

                self.timer?.invalidate()
                self.timer = NSTimer.every(1.0 / Double(n)) {
                    bus.post("Event")
                }
            }

            bus.register("Event") { name, _ in
                print(name)
            }
        })

        webView.scrollView.bounces = false
        view.addSubview(webView)

        webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource("responsiveness_benchmark", withExtension: "html")!))
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        bus?.unregister()
        bus = nil
        timer?.invalidate()
        timer = nil
    }
}