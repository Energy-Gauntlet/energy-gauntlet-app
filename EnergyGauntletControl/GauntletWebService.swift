import Foundation

protocol GauntletWebServiceDelegate {
    func serviceDidUpdate(commands: NSArray)
}

class GauntletWebService {
    var delegate:GauntletWebServiceDelegate?

    static let urlPath: String = "http://energy-gauntlet.mybluemix.net/what-should-i-do?"
    let url: NSURL = NSURL(string: urlPath)!
    
    func poll() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var commands: NSArray = self.getServiceState()
            if commands.count < 1 {
                return;
            }
            self.delegate?.serviceDidUpdate(commands)
        });
    }
        
    func getServiceState() -> NSArray {
        var request: NSURLRequest = NSURLRequest(URL: self.url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        
        var err: NSError
        var jsonResult: NSArray = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
        return jsonResult
        
    }
}

