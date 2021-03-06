import Caravel
import WebKit

class BaseCaravel: ICaravelPage {
    var bus: EventBus?

    func setDraft(webView: WKWebView, draft: EventBus.Draft, config: WKWebViewConfiguration) {
        // To be overridden
    }

    func isMovingToAnotherPage() {
    }

    func viewWillBeRecycled() {
        bus?.unregister()
        bus = nil
    }
}