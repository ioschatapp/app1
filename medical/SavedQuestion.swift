//
//  SavedQuestion.swift
//  medical
//
//  Created by Y YM on 2020/11/6.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit
import CoreData

class SavedQuestionController: UITableViewController, UISearchBarDelegate, Action {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allQuestion: [SaveQuestion] = []
    
    var filterQuestion: [SaveQuestion] = []
    
    var topic: Topic? = nil
    
    var notify: Action? = nil
    
    func setTopic(topic: Topic) {
        self.topic = topic
    }
    
    func onAction() {
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
//        self.tableView.register(SaveQuestionCell.self, forCellReuseIdentifier: "questions")
        self.tableView.rowHeight = UITableView.automaticDimension
        print("Here")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func refresh() {
        loadData()
        self.searchBar(self.searchBar, textDidChange: self.searchBar.text ?? "")
    }
    
    func loadData() {
        let quesRequest: NSFetchRequest<SaveQuestion> = SaveQuestion.fetchRequest()
        print("Load Fav")
        let predicate = NSPredicate(format: "username = %@ AND topic = %@", Global.USER_INFO!.username!, topic!.topic!)
        quesRequest.predicate = predicate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let delegate = appDelegate.persistentContainer.viewContext
        do {
            allQuestion = try (delegate.fetch(quesRequest))
        } catch {
            print("Fetch failed")
            return
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimSearch == "" {
            filterQuestion = allQuestion
        } else {
            filterQuestion = []
            for i in allQuestion {
                if i.question!.question!.contains(trimSearch) {
                    filterQuestion.append(i)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterQuestion.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "questions", for: indexPath) as! SaveQuestionCell
//        if cell.questionContent == nil {
//            cell = SaveQuestionCell(style: .default, reuseIdentifier: "questions")
//        }
        let question = filterQuestion[indexPath.row]
        cell.questionContent.text = question.question!.question
        cell.setQuestion(question)
        cell.callback = {
            self.refresh()
            self.notify?.onAction()
        }
        return cell
    }
    
}

