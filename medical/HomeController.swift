//
//  HomeController.swift
//  medical
//
//  Created by Y YM on 2020/11/4.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var topics: [SaveTopics] = []
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: searchField.frame.height - 1, width: searchField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        searchField.borderStyle = UITextField.BorderStyle.none
        searchField.layer.addSublayer(bottomLine)
        
        self.tableView.register(SavedTopicsCell.self, forCellReuseIdentifier: "topics")
        
        let topicRequest: NSFetchRequest<SaveTopics> = SaveTopics.fetchRequest()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        do {
            topics = try (delegate?.fetch(topicRequest))!
            print(topics)
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier: String = "topics"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topics", for: indexPath) as? UITableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let topic = topics[indexPath.row]
        
        cell.textLabel?.text = topic.topic?.topic

        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
