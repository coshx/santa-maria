import Caravel
import WebKit

class SimpleEventCaravel: ICaravelPage {

    func setDraft(webView: WKWebView, draft: EventBus.Draft) {
        Caravel.get(self, name: "SimpleEvent", wkWebView: webView, draft: draft, whenReady: { bus in
            bus.register("Send") { _, _ in
                bus.post("Received")
            }
        })
    }

    func isMovingToAnotherPage() {
        // Nothing to do
    }
}