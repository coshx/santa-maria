import Caravel
import WebKit

class TwoBusesCaravel: ICaravelPage {
    private var isFirstTime = true
    private var bus1: EventBus?
    private var bus2: EventBus?

    func setDraft(webView: WKWebView, draft: EventBus.Draft) {
        var name = "TwoBuses-2"

        if isFirstTime {
            isFirstTime = false
            name = "TwoBuses-1"
        }

        Caravel.get(self, name: name, wkWebView: webView, draft: draft, whenReady: { bus in
            if name == "TwoBuses-1" {
                self.bus1 = bus
            } else {
                self.bus2 = bus
            }

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
        bus2?.unregister()
        isFirstTime = true
    }
}