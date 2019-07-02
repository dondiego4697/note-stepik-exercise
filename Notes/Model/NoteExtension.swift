import Foundation
import UIKit

extension Note {
    static func stringToPriority(_ p: String?) -> Priority? {
        switch p {
        case "high":
            return Priority.high
        case "base":
            return Priority.base
        case "low":
            return Priority.low
        default:
            return nil
        }
    }
    
    static func priorityToString(_ p: Priority) -> String {
        switch p {
        case .base:
            return "base"
        case .high:
            return "high"
        case .low:
            return "low"
        }
    }
    
    static func colorToJson(_ c: UIColor?) -> [CGFloat]? {
        guard (c != nil) else {
            return nil
        }
        
        var color: [CGFloat] = []
        for (i, n) in (c!.cgColor.components ?? []).enumerated() {
            if i != 3 {
                color.append(n * 255)
            } else {
                color.append(n)
            }
        }
        
        return color
    }
    
    static func parse(json: [String: Any]) -> Note? {
        guard
            let title = json["title"] as? String,
            let content = json["content"] as? String
            else {
                return nil
        }
        
        let uid = json["uid"] as? String
        let priority = Note.stringToPriority(json["priority"] as? String)
        
        var color: UIColor? = nil
        if json["color"] != nil {
            var colorSet: [CGFloat] = [];
            for v in json["color"] as! [Double] {
                let colorFloat = NSNumber.init(value: v).floatValue
                colorSet.append(CGFloat(colorFloat))
            }
            
            color = UIColor.init(
                red: colorSet[0] / 255,
                green: colorSet[1] / 255,
                blue: colorSet[2] / 255,
                alpha: colorSet[3]
            )
        }
        
        let expiredDate = Date.stringToDate(json["expiredDate"] as? String)
        
        let note = Note(
            title: title,
            content: content,
            priority: priority,
            uid: uid,
            color: color,
            expiredDate: expiredDate
        )
        
        return note
    }
    
    var json: [String: Any] {
        var result = [String: Any]()
        
        result["uid"] = self.uid
        result["title"] = self.title
        result["content"] = self.content
        
        result["color"] = Note.colorToJson(self.color)
        
        if self.expiredDate != nil {
            result["expiredDate"] = Date.dateToString(self.expiredDate!)
        }
        
        if self.priority != Priority.base {
            result["priority"] = Note.priorityToString(self.priority)
        }
        
        return result
    }
}
