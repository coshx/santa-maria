import Caravel
import WebKit

protocol ICaravelPage {
    func setDraft(webView: WKWebView,  draft: EventBus.Draft,config: WKWebViewConfiguration)

    func isMovingToAnotherPage()

    func viewWillBeRecycled()
}
