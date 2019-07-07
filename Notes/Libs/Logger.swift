import Foundation
import CocoaLumberjack

class Logger {
    static let logger: Logger = Logger()
    
    private init() {
        DDTTYLogger.sharedInstance.logFormatter = LogFormatter()
        DDLog.add(DDOSLogger.sharedInstance)
    }
    
    public func error(_ message: String) -> Void {
        DDLogError(message)
    }
    
    public func info(_ message: String) -> Void {
        DDLogInfo(message)
    }
}
