import UIKit
import WebKit
import Caravel
import SwiftyTimer
import Async

class ResponsivenessBenchmarkController: BaseController {
    private var timer: NSTimer?

    private var currentComplexity = 1
    private var currentDataSet: [AnyObject]?

    override func whenBusReady() {
        if let bus = self.bus {
            bus.registerOnMain("EventNumber") { name, data in
                let n = data as! Int

                if self.currentDataSet == nil {
                    self.currentDataSet = ResponsivenessBenchmarkData.generate(self.currentComplexity)
                }

                self.timer?.invalidate()
                self.timer = NSTimer.every(1.0 / Double(n)) {
                    Async.background { bus.post("Event") }
                }
            }

            bus.registerOnMain("EventComplexity") { name, data in
                let n = data as! Int

                self.currentComplexity = n
                self.currentDataSet = ResponsivenessBenchmarkData.generate(self.currentComplexity)
            }

            bus.register("Event") { name, _ in
                print(name)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPage("responsiveness_benchmark", busName: "ResponsivenessBenchmark", exitSegueIdentifier: R.segue.exitResponsivenessBenchmark)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}