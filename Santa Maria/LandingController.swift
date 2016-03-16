import UIKit
import WebKit
import Caravel

class LandingController: BaseController {

    override func whenBusReady() {
        guard let bus = self.bus else {
            return
        }

        bus.register("Slideshow") { _, _ in
            self.performSegueWithIdentifier(R.segue.showSlideshow, sender: self)
        }

        bus.register("TimeBenchmark") { _, _ in
            self.performSegueWithIdentifier(R.segue.showTimeBenchmark, sender: self)
        }

        bus.register("ResponsivenessBenchmark") { _, _ in
            self.performSegueWithIdentifier(R.segue.showResponsivenessBenchmark, sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPage("landing", busName: "Landing")
    }

    @IBAction func backFromSlideshow(segue: UIStoryboardSegue) {
    }

    @IBAction func backFromTimeBenchmark(segue: UIStoryboardSegue) {
    }

    @IBAction func backFromResponsivenessBenchmark(segue: UIStoryboardSegue) {
    }
}
