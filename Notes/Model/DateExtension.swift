import Foundation
import UIKit

extension Date {
    static func stringToDate(_ d: String?) -> Date? {
        guard (d != nil) else {
            return nil
        }

        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return fmt.date(from: d!)
    }

    static func dateToString(_ d: Date) -> String? {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return fmt.string(from: d)
    }
}
