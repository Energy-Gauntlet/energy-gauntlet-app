import UIKit

class MainViewController: UIKit.UIViewController, DRDoubleDelegate, GauntletWebServiceDelegate {

    let webService = GauntletWebService()
    var runPollService = false
    var driveState = DriveState()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService.delegate = self;
        DRDouble.sharedDouble().delegate = self
        
    }
    
    func serviceDidUpdate(commands: NSArray) {
        
        for command in commands {
            updateRobotState(command as! NSDictionary)
        }

        if (runPollService) {
            webService.poll()
        }
    }
    
    
    func doubleDriveShouldUpdate(theDouble: DRDouble!) {
        DRDouble.sharedDouble().variableDrive(driveState.driveDirection, turn: driveState.turnDirection)
    }
    
    // MARK: - robot commands
    func updateRobotState(command: NSDictionary) {
        println(command)
        var command_type:String = command["type"] as! String
        
        switch command_type {
        case "poleUp":
            poleUp()
        case "poleStop":
            poleStop()
        case "poleDown":
            poleDown()
        case "deployKickstands":
            deployKickstands()
        case "retractKickstands":
            retractKickstands()
        case "variableDrive":
            updateDriveState(command["values"] as! NSDictionary)
        default:
            println("BROKEN")
        }
    }

    // MARK: - commands
    func updateDriveState(values: NSDictionary) {
        driveState.driveDirection = values["forwardBack"] as! Float
        driveState.turnDirection = values["leftRight"] as! Float
    }
    
    func poleUp() {
        println("moving pole up")
        DRDouble.sharedDouble().poleUp()
    }
    
    func poleDown() {
        println("moving pole down")
        DRDouble.sharedDouble().poleDown()
    }
    
    func poleStop() {
        println("stop that pole")
        DRDouble.sharedDouble().poleStop()
    }
    
    func deployKickstands() {
        println("kickstands down")
        DRDouble.sharedDouble().deployKickstands()
    }
    
    func retractKickstands() {
        println("kickstands up")
        DRDouble.sharedDouble().retractKickstands()
    }

    // MARK: - buttons
    @IBAction func startPoll(sender: AnyObject) {
        runPollService = true
        webService.poll()
    }
    
    @IBAction func stopPoll(sender: AnyObject) {
        runPollService = false
        driveState.stopAll()
    }
    
    @IBAction func kickstandUp(sender: AnyObject) {
        retractKickstands()
    }
    @IBAction func kickstandDown(sender: AnyObject) {
        deployKickstands()
    }

}
