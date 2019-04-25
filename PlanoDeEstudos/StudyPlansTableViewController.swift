//
//  NotificationsTableViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class StudyPlansTableViewController: UITableViewController {
    let studyManager = StudyManager.shared
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "dd/MM/yy HH:mm"
        return dt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceived(notification:)), name: NSNotification.Name("Confirmed"), object: nil)
    }
    
    @objc func onReceived(notification: Notification) {
        if let userInfo = notification.userInfo, let id = userInfo["id"] as? String {
            studyManager.setPlanDone(with: id)
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyManager.studyPlans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let studyPlan = studyManager.studyPlans[indexPath.row]
        cell.textLabel?.text = studyPlan.section
        cell.detailTextLabel?.text = dateFormatter.string(from: studyPlan.date)
        
        if studyPlan.done {
            cell.backgroundColor = .green 
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studyManager.removePlan(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }


}
