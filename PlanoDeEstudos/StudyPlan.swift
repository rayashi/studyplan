
import Foundation


class StudyPlan: Codable {
    let id: String
    let course: String
    let section: String
    var date: Date
    var done: Bool = false
    
    init(id: String, course: String, section: String, date: Date, done: Bool) {
        self.id = id
        self.course = course
        self.section = section
        self.date = date
        self.done = done
    }
    
}
