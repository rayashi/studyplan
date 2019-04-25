

import Foundation


class StudyManager {
    
    static let shared = StudyManager()
    var studyPlans: [StudyPlan] = []
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: "studyPlans"),
           let plans = try? JSONDecoder().decode([StudyPlan].self, from: data){
            self.studyPlans = plans
        }
    }
    
    func savePlans() {
        if let data = try? JSONEncoder().encode(studyPlans) {
            UserDefaults.standard.set(data, forKey: "studyPlans")
        }
    }
    
    func addPlan(_ studyPlan: StudyPlan) {
        studyPlans.append(studyPlan)
        savePlans()
    }
    
    func removePlan(at index: Int) {
        studyPlans.remove(at: index)
        savePlans()
    }
}
