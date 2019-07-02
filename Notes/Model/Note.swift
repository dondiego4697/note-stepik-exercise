import Foundation
import UIKit

typealias UID = String

enum Priority {
    case high
    case base
    case low
}

struct Note {
    let uid: UID
    let title: String
    let content: String
    let color: UIColor
    let priority: Priority
    let expiredDate: Date?
    
    init(
        title: String,
        content: String,
        priority: Priority? = nil,
        uid: UID? = nil,
        color: UIColor? = nil,
        expiredDate: Date? = nil
        ) {
        self.uid = uid ?? UUID().uuidString
        self.title = title
        self.content = content
        self.color = color ?? UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        self.priority = priority ?? Priority.base
        self.expiredDate = expiredDate
    }
}
