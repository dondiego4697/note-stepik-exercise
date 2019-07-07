import Foundation
import CocoaLumberjack

public class LogFormatter: NSObject, DDLogFormatter {
    
    let dateFormmater = DateFormatter()
    
    public override init() {
        dateFormmater.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"

        super.init()
    }
    
    public func format(message logMessage: DDLogMessage) -> String? {
        let logLevel: String
        switch logMessage.flag {
        case DDLogFlag.error:
            logLevel = "ERROR"
        case DDLogFlag.warning:
            logLevel = "WARNING"
        case DDLogFlag.info:
            logLevel = "INFO"
        case DDLogFlag.debug:
            logLevel = "DEBUG"
        default:
            logLevel = "VERBOSE"
        }
        
        let dt = dateFormmater.string(from: logMessage.timestamp)
        let logMsg = logMessage.message
        let lineNumber = logMessage.line
        let file = logMessage.fileName
        let functionName = logMessage.function
        let threadId = logMessage.threadID
        
        return "\(dt) [\(threadId)] [\(logLevel)] [\(file):\(lineNumber)]\(String(describing: functionName)) - \(logMsg)"
    }
}
