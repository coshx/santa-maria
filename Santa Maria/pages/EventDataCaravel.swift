import Caravel
import WebKit

class EventDataCaravel: BaseCaravel {
    override func setDraft(webView: WKWebView, draft: EventBus.Draft, config: WKWebViewConfiguration) {
        Caravel.get(self, name: "EventData", wkWebView: webView, draft: draft, whenReady: { bus in
            self.bus = bus

            bus.register("Cross") { _, integer in
                bus.post("Cross", data: 69)
            }

            bus.register("Circle") { _, string in
                bus.post("Circle", data: "Georges Lucas")
            }

            bus.register("Triangle") { _, array in
                bus.post("Triangle", data: [100, 101, 201, 302, 503])
            }

            bus.register("Square") { _, hash in
                bus.post("Square", data: ["name": "Coshx Labs", "address": "Impact Hub - SF"])
            }
        })
    }
}