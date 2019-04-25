//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    var studyManager = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dpDate.minimumDate = Date()
    }

    @IBAction func schedule(_ sender: UIButton) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(id: id, course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false)
        studyManager.addPlan(studyPlan)
        createNotification(with: studyPlan)
        navigationController?.popViewController(animated: true)
    }
    
    func createNotification(with studyPlan: StudyPlan) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Lembrete"
        notificationContent.subtitle = "Matéria \(studyPlan.course)"
        notificationContent.body = "Estudar \(studyPlan.section)"
        notificationContent.categoryIdentifier = "Lembrete"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        let request = UNNotificationRequest(identifier: studyPlan.id, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
