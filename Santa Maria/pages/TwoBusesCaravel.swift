import Caravel
import WebKit

class TwoBusesCaravel: ICaravelPage {
    private var isFirstTime = true
    private let ref1 = NSObject()
    private let ref2 = NSObject()

    private var bus1: EventBus?
    private var bus2: EventBus?

    func setDraft(webView: WKWebView, draft: EventBus.Draft, config: WKWebViewConfiguration) {
        Caravel.get(ref1, name: "TwoBuses-1", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus1 = bus
            bus.register("Send") { _, _ in
                bus.post("Received")
            }
        })
        Caravel.get(ref2, name: "TwoBuses-2", wkWebView: webView, draft: Caravel.getDraft(config), whenReady: { bus in
            self.bus2 = bus
            bus.register("Send") { _, _ in
                bus.post("Received")
            }
        })
    }

    func isMovingToAnotherPage() {
        // Nothing to do
    }

    func viewWillBeRecycled() {
        bus1?.unregister()
        bus1 = nil
        bus2?.unregister()
        bus2 = nil
        isFirstTime = true
    }
}