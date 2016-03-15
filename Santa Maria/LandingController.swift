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
        self.webView = webView

        Caravel.get(self, name: "Landing", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus = bus

            bus.register("Slideshow") { _, _ in
                self.performSegueWithIdentifier(R.segue.showSlideshow, sender: self)
            }

            bus.register("DurationBenchmark") { _, _ in
                self.performSegueWithIdentifier(R.segue.showDurationBenchmark, sender: self)
            }
        })

        webView.scrollView.bounces = false
        view.addSubview(webView)

        webView.loadRequest(NSURLRequest(URL: NSBundle.mainBundle().URLForResource("landing", withExtension: "html")!))
    }

    @IBAction func backFromSlideshow(segue: UIStoryboardSegue) {
    }

    @IBAction func backFromDurationBenchmark(segue: UIStoryboardSegue) {
    }
}
