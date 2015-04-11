import UIKit

class MainViewController: UIKit.UIViewController, DRDoubleDelegate, GauntletWebServiceDelegate {

    let webService = GauntletWebService()
    var runPollService = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService.delegate = self;
        DRDouble.sharedDouble().delegate = self
        
    }

    func doubleDriveShouldUpdate(theDouble: DRDouble!) {
        DRDouble.sharedDouble().drive(DRDriveDirection.Stop, turn: 1.0)
        
        //    - (void)doubleDriveShouldUpdate:(DRDouble *)theDouble {
        //    float drive = (driveForwardButton.highlighted) ? kDRDriveDirectionForward : ((driveBackwardButton.highlighted) ? kDRDriveDirectionBackward : kDRDriveDirectionStop);
        //    float turn = (driveRightButton.highlighted) ? 1.0 : ((driveLeftButton.highlighted) ? -1.0 : 0.0);
        //    [theDouble drive:drive turn:turn];
        //    }
        //
    }
    
    func serviceDidUpdate(commands: NSArray) {
        println(commands)
        if (runPollService) {
            webService.poll()
        }
    }
    
    // MARK: - buttons

    @IBAction func startPoll(sender: AnyObject) {
        runPollService = true
        webService.poll()
    }
    
    @IBAction func stopPoll(sender: AnyObject) {
        //also clear command state here
        runPollService = false
    }
    
    @IBAction func moveStandUp(sender: AnyObject) {
        DRDouble.sharedDouble().poleUp()
    }
    
    @IBAction func moveStandDown(sender: AnyObject) {
        DRDouble.sharedDouble().poleDown()
    }
    
    @IBAction func kickstandUp(sender: AnyObject) {
        DRDouble.sharedDouble().retractKickstands()
    }
    @IBAction func kickstandDown(sender: AnyObject) {
        DRDouble.sharedDouble().deployKickstands()
    }

}
