import UIKit
import WebKit
import Caravel

class LandingController: UIViewController {
    private var webView: WKWebView?
    private var bus: EventBus?

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        let draft = Caravel.getDraft(config)

        let webView = WKWebView(frame: view.frame, configuration: config)

        Caravel.get(self, name: "Landing", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus = bus

            bus.register("Slideshow") { _, _ in
            }

            bus.register("Duration Benchmark") { _, _ in
            }
        })

        webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource("landing", withExtension: "html")!))
    }

    @IBAction func backFromSlideshow(segue: UIStoryboardSegue) {
    }
}
