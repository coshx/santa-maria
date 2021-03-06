import UIKit
import WebKit
import Caravel

class TimeBenchmarkController: BaseController {
    private let noDataRef = NSObject()
    private var noDataBus: EventBus?

    private let stringRef = NSObject()
    private var stringBus: EventBus?

    private let arrayRef = NSObject()
    private var arrayBus: EventBus?

    private let dictionaryRef = NSObject()
    private var dictionaryBus: EventBus?

    private let complexRef = NSObject()
    private var complexBus: EventBus?

    private var streamSize: Int?
    private var initializedBuses = 0
    private let nbBuses = 5 + 1

    private func flagBusAsInit() {
        initializedBuses++
        if initializedBuses == nbBuses {
            self.bus!.post("Ready")
        }
    }

    override func whenBusReady() {
        guard let bus = self.bus else {
            return
        }

        bus.registerOnMain("StreamSize") { _, data in
            let s = data as! Int

            self.streamSize = s

            if let b = self.noDataBus {
                for i in 0 ..< s {
                    b.register("Event-\(i)") { name, _ in
                        b.post(name)
                    }
                }
            }

            if let b = self.stringBus {
                for i in 0 ..< s {
                    b.register("Event-\(i)") { name, rawData in
                        let data = rawData as! String
                        b.post(name, data: data)
                    }
                }
            }

            if let b = self.arrayBus {
                for i in 0 ..< s {
                    b.register("Event-\(i)") { name, rawData in
                        let data = rawData as! [Int]
                        b.post(name, data: data)
                    }
                }
            }

            if let b = self.dictionaryBus {
                for i in 0 ..< s {
                    b.register("Event-\(i)") { name, rawData in
                        let data = rawData as! [String: AnyObject]
                        b.post(name, data: data)
                    }
                }
            }

            if let b = self.complexBus {
                for i in 0 ..< s {
                    b.register("Event-\(i)") { name, rawData in
                        let data = rawData as! [String: AnyObject]
                        b.post(name, data: data)
                    }
                }
            }

            self.flagBusAsInit()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPage("time_benchmark", busName: "TimeBenchmark", exitSegueIdentifier: R.segue.exitTimeBenchmark)

        guard let config = webViewConfig else {
            fatalError()
        }

        guard let webView = self.webView else {
            fatalError()
        }

        Caravel.get(noDataRef, name: "NoData", wkWebView: webView, draft: Caravel.getDraft(config), whenReadyOnMain: { bus in
            self.noDataBus = bus

            if let s = self.streamSize {
                for i in 0 ..< s {
                    bus.register("Event-\(i)") { name, _ in
                        bus.post(name)
                    }
                }
            }

            self.flagBusAsInit()
        })

        Caravel.get(stringRef, name: "String", wkWebView: webView, draft: Caravel.getDraft(config), whenReadyOnMain: { bus in
            self.stringBus = bus

            if let s = self.streamSize {
                for i in 0 ..< s {
                    bus.register("Event-\(i)") { name, rawData in
                        let data = rawData as! String
                        bus.post(name, data: data)
                    }
                }
            }

            self.flagBusAsInit()
        })

        Caravel.get(arrayRef, name: "Array", wkWebView: webView, draft: Caravel.getDraft(config), whenReadyOnMain: { bus in
            self.arrayBus = bus

            if let s = self.streamSize {
                for i in 0 ..< s {
                    bus.register("Event-\(i)") { name, rawData in
                        let data = rawData as! [Int]
                        bus.post(name, data: data)
                    }
                }
            }

            self.flagBusAsInit()
        })

        Caravel.get(dictionaryRef, name: "Dictionary", wkWebView: webView, draft: Caravel.getDraft(config), whenReadyOnMain: { bus in
            self.dictionaryBus = bus

            if let s = self.streamSize {
                for i in 0 ..< s {
                    bus.register("Event-\(i)") { name, rawData in
                        let data = rawData as! [String: AnyObject]
                        bus.post(name, data: data)
                    }
                }
            }

            self.flagBusAsInit()
        })

        Caravel.get(complexRef, name: "Complex", wkWebView: webView, draft: Caravel.getDraft(config), whenReadyOnMain: { bus in
            self.complexBus = bus

            if let s = self.streamSize {
                for i in 0 ..< s {
                    bus.register("Event-\(i)") { name, rawData in
                        let data = rawData as! [String: AnyObject]
                        bus.post(name, data: data)
                    }
                }
            }

            self.flagBusAsInit()
        })
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        self.initializedBuses = 0
        self.streamSize = nil

        self.noDataBus?.unregister()
        self.noDataBus = nil
        self.stringBus?.unregister()
        self.stringBus = nil
        self.arrayBus?.unregister()
        self.arrayBus = nil
        self.dictionaryBus?.unregister()
        self.dictionaryBus = nil
        self.complexBus?.unregister()
        self.complexBus = nil
    }
}
