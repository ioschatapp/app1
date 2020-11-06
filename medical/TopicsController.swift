//
//  TopicsController.swift
//  medical
//
//  Created by Y YM on 2020/11/4.
//  Copyright © 2020 edu. All rights reserved.
//


import UIKit
import CoreData

class TopicController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    lazy var faButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("ADD", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(fabTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func fabTapped(_ button: UIButton) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "CREAT TOPIC", message: nil, preferredStyle: .alert)
        
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter topic name, No duplicate!"
        }
//
//        alert.addTextField { (textFieldPass) in
//            textFieldPass.placeholder = "Password"
//            textFieldPass.isSecureTextEntry = true
//        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            var topicText = alert?.textFields![0].text ?? ""
            topicText = topicText.trimmingCharacters(in: .whitespacesAndNewlines)
            if (topicText.isEmpty) {
                print("Empty")
                self.toast(msg: "Empty topic not allowed.")
                return
            }
            
            // check if already in data
            for i in self.allTopics {
                if (i.topic! == topicText) {
                    self.toast(msg: "Duplicate topic not allowed.")
                    return
                }
            }
            
            // todo: add topic
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let managedContext =
                appDelegate.persistentContainer.viewContext
            let entity =
                NSEntityDescription.entity(forEntityName: "Topic",
                                           in: managedContext)!
            let person = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            person.setValue(topicText, forKeyPath: "topic")
            do {
                try managedContext.save()
                print("saved")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            self.fetchData()
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    var savedTopics: [Topic] = []
    
    var allTopics: [Topic] = []
    
    var filterTopic: [Topic] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "topics")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let view = UIApplication.shared.keyWindow {
            view.addSubview(faButton)
            setupButton()
            faButton.isHidden = false
        }
        self.fetchData()
    }
    
    func fetchData() {
        fetchSavedTopics()
        fetchAllTopics()
        self.searchBar(searchBar, textDidChange: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimSearch == "" {
            filterTopic = allTopics
        } else {
            filterTopic = []
            for i in allTopics {
                if i.topic!.contains(trimSearch) {
                    filterTopic.append(i)
                }
            }
        }
    
        self.tableView.reloadData()
    }
    
    func fetchAllTopics() {
        let topicRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        do {
            allTopics = try (delegate?.fetch(topicRequest)) ?? []
            print(allTopics)
        } catch {
            print("Fetch failed")
        }
    }
    
    func fetchSavedTopics() {
        let topicRequest: NSFetchRequest<SaveTopics> = SaveTopics.fetchRequest()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        do {
            savedTopics = (try (delegate?.fetch(topicRequest)) ?? []).compactMap { $0.topic }
        } catch {
            print("Fetch failed")
        }
    }
    
    func setupButton() {
        NSLayoutConstraint.activate([
            faButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            faButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            faButton.heightAnchor.constraint(equalToConstant: 60),
            faButton.widthAnchor.constraint(equalToConstant: 60)
            ])
        faButton.layer.cornerRadius = 30
        faButton.layer.masksToBounds = true
        faButton.layer.borderWidth = 2
        faButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        faButton.isHidden = true
        view.willRemoveSubview(faButton)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTopic.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath.row)")
        let detailsView = self.storyboard?.instantiateViewController(withIdentifier: "topicDetailsController") as! TopicDetailsController

        detailsView.setTopic(topic: filterTopic[indexPath.row])
//        self.present(detailsView, animated: true)
        self.navigationController!.pushViewController(detailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "topics", for: indexPath)
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "topics")
        }
        let topic = filterTopic[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        for x in savedTopics {
            if x.topic == topic.topic {
                cell.textLabel?.textColor = UIColor.red
                break
            }
        }
        cell.textLabel?.text = topic.topic
        cell.detailTextLabel?.text = String(topic.questions?.count ?? 0) + " saved"
        return cell
    }
    
    func toast(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
