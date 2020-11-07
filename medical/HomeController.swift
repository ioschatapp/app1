//
//  HomeController.swift
//  medical
//
//  Created by Y YM on 2020/11/4.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    var allTopics: [SaveTopics] = []
    var filterTopic: [SaveTopics] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func refresh() {
        print("On Refresh")
        loadData()
        self.searchBar(self.searchBar, textDidChange: self.searchBar.text ?? "")
    }
    
    func loadData() {
        let topicRequest: NSFetchRequest<SaveTopics> = SaveTopics.fetchRequest()
        let delegate = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let predicate = NSPredicate(format: "username = %@", Global.USER_INFO!.username!)
        topicRequest.predicate = predicate
        do {
            allTopics = (try (delegate?.fetch(topicRequest)) ?? [])
        } catch {
            print("Fetch failed")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimSearch == "" {
            filterTopic = allTopics
        } else {
            filterTopic = []
            for i in allTopics {
                if i.topic!.topic!.contains(trimSearch) {
                    filterTopic.append(i)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath.row)")
        let detailsView = self.storyboard?.instantiateViewController(withIdentifier: "topicDetailsController") as! TopicDetailsController
        
        detailsView.setTopic(topic: filterTopic[indexPath.row].topic!)
        self.navigationController!.pushViewController(detailsView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "save_topics", for: indexPath) as! SaveTopicFavCell
        
        let topic = filterTopic[indexPath.row]
        cell.isLike.isOn = true
        cell.topic.text = topic.topic!.topic
        cell.questionNum.text = String(topic.topic!.questions?.count ?? 0) + " saved"
        cell.setTopic(topic)
        cell.callback = {
            self.refresh()
        }
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        refresh()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        allTopics = []
        filterTopic = []
        tableView.reloadData()
    }
}
