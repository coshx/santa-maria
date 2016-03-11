import Caravel
import WebKit

class TwoBusesCaravel: ICaravelPage {
    private var isFirstTime = true

    func setDraft(webView: WKWebView, draft: EventBus.Draft) {
        var name = "TwoBuses-2"

        if isFirstTime {
            isFirstTime = false
            name = "TwoBuses-1"
        }

        Caravel.get(self, name: name, wkWebView: webView, draft: draft, whenReady: { bus in
            bus.register("Send") { _, _ in
                bus.post("Received")
            }
        })
    }

    func isMovingToAnotherPage() {
        // Nothing to do
    }
}