import Caravel
import WebKit

class MultipleSubscribersCaravel: BaseCaravel {
    override func setDraft(webView: WKWebView, draft: EventBus.Draft, config: WKWebViewConfiguration) {
        Caravel.get(self, name: "MultipleSubscribers", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus = bus
            bus.register("Send") { _, _ in
                bus.post("Received")
            }
        })
    }
}