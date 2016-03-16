import UIKit
import WebKit
import Caravel

class LandingController: BaseController {

    override var headerColor: UIColor {
        return UIColor(red: 240.0 / 255.0, green: 152.0 / 255.0, blue: 25.0 / 255.0, alpha: 1)
    }

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
