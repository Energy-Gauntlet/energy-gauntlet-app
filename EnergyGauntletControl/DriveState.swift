import Foundation

class DriveState {
    
    var driveDirection:Float = 0
    var turnDirection:Float = 0
    
    func stopAll() {
        driveDirection = 0
        turnDirection = 0
    }
}