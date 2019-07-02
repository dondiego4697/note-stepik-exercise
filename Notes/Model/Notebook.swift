import Foundation
import UIKit

enum NotebookError: Error {
    case WrongFilePath(String)
    case CouldntCreateFile(String)
    case CouldntParseFile(String)
}

class Notebook {
    private(set) var notes = Dictionary<UID, Note>()
    
    public func add(_ note: Note) {
        if !self.notes.keys.contains(note.uid) {
            self.notes[note.uid] = note
        }
    }
    
    public func remove(_ uid: UID) {
        self.notes.removeValue(forKey: uid)
    }
    
    private func getPath() -> String? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        if let pathComponent = url.appendingPathComponent("notebook.save") {
            return pathComponent.path
        } else {
            return nil
        }
    }
    
    public func saveToFile() throws -> Void {
        let filePath = self.getPath()
        if filePath == nil {
            throw NotebookError.WrongFilePath("")
        }
        
        let result = self.notes.map{ (_, note) -> [String: Any] in
            note.json
        }
        
        let data = try JSONSerialization.data(withJSONObject: result, options: [])
        let res = FileManager.default.createFile(atPath: filePath!, contents: data, attributes: nil)
        if !res {
            throw NotebookError.CouldntCreateFile("")
        }
    }
    
    public func loadFromFile() throws -> Void {
        let filePath = self.getPath()
        if filePath == nil {
            throw NotebookError.WrongFilePath("")
        }
        
        let string = try String(contentsOfFile: filePath!)
        let data = string.data(using: .utf8)!
        
        let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
        
        if jsonArray == nil {
            throw NotebookError.CouldntParseFile("")
        }
        
        for item in jsonArray! {
            let note = Note.parse(json: item)
            if (note != nil) {
                self.add(note!)
            }
        }
    }
}
