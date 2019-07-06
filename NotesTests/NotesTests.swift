import XCTest
@testable import Notes

class NotesTests: XCTestCase {
    
    static func getExpiredDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: "2019/10/08")
    }
    
    static let TITLE = "TestTitle"
    static let CONTENT = "TestContent"
    static let UID = "TestUID"
    static let COLOR = UIColor.init(red: 11, green: 2, blue: 3, alpha: 0.1)
    
    func testNoteCreationDefaults() {
        let note = Note(
            title: NotesTests.TITLE,
            content: NotesTests.CONTENT,
            expiredDate: NotesTests.getExpiredDate()
        )
        
        XCTAssertNotNil(note.uid)
        XCTAssertTrue(note.title == NotesTests.TITLE)
        XCTAssertTrue(note.content == NotesTests.CONTENT)
        XCTAssertTrue(note.color == UIColor.init(red: 255, green: 255, blue: 255, alpha: 1))
        XCTAssertTrue(note.priority == Priority.base)
        XCTAssertTrue(note.expiredDate == NotesTests.getExpiredDate())
    }
    
    func testNoteCreationInit() {
        let note = Note(
            title: "TestTitle",
            content: "TestContent",
            priority: Priority.high,
            uid: NotesTests.UID,
            color: NotesTests.COLOR,
            expiredDate: NotesTests.getExpiredDate()
        )
        
        XCTAssertTrue(note.uid == NotesTests.UID)
        XCTAssertTrue(note.title == NotesTests.TITLE)
        XCTAssertTrue(note.content == NotesTests.CONTENT)
        XCTAssertTrue(note.color == NotesTests.COLOR)
        XCTAssertTrue(note.priority == Priority.high)
        XCTAssertTrue(note.expiredDate == NotesTests.getExpiredDate())
    }
    
}
