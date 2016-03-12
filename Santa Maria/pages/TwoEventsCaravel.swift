import Caravel
import WebKit

class TwoEventsCaravel: BaseCaravel {
    override func setDraft(webView: WKWebView, draft: EventBus.Draft, config: WKWebViewConfiguration) {
        Caravel.get(self, name: "TwoEvents", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus = bus
            bus.register("A") { _, _ in bus.post("C") }
            bus.register("B") { _, _ in bus.post("D") }
        })
    }
}