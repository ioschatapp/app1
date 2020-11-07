//
//  BrowseController.swift
//  medical
//
//  Created by Y YM on 2020/11/6.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit
import CoreData

class BrowseController: UIViewController, Action {
    
    var curIndex = 0
    var topic: Topic? = nil
    var isCurLike = false
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var questionContent: UILabel!
    var userFav: [SaveQuestion] = []
    var curLikeObject: SaveQuestion? = nil
    var notify: Action? = nil
    
    @IBOutlet weak var likeButton: UIButton!
    
    func setTopic(topic: Topic) {
        self.topic = topic
        self.curIndex = 0
    }
    
 
    
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
        let alert = UIAlertController(title: "CREAT QUESTION", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter question content."
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            var questionText = alert?.textFields![0].text ?? ""
            questionText = questionText.trimmingCharacters(in: .whitespacesAndNewlines)
            if (questionText.isEmpty) {
                print("Empty")
                self.toast(msg: "Empty question not allowed.")
                return
            }
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let managedContext =
                appDelegate.persistentContainer.viewContext
            let ques = Question(context: managedContext)
            ques.question = questionText
            ques.community = false

            self.topic!.addToQuestions(ques)
            do {
                try managedContext.save()
                print("saved")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            print(self.topic?.questions?.count ?? -1)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground.layer.shadowColor = UIColor.black.cgColor
        viewBackground.layer.masksToBounds = false
        questionContent.text = "This is a long Test Questiong Content"
        print(Global.USER_INFO!)
    }
    
    
    func toast(msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let view = UIApplication.shared.keyWindow {
            view.addSubview(faButton)
            setupButton()
            faButton.isHidden = false
        }
        // self.fetchData()
        loadFav()
        showQuestion()
    }
    
    
    func loadFav() {
        let quesRequest: NSFetchRequest<SaveQuestion> = SaveQuestion.fetchRequest()
        let predicate = NSPredicate(format: "username = %@ AND topic = %@", Global.USER_INFO!.username!, topic!.topic!)
        quesRequest.predicate = predicate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let delegate = appDelegate.persistentContainer.viewContext
        do {
            userFav = try (delegate.fetch(quesRequest))

        } catch {
            print("Fetch failed")
            return
        }
    }
    
    func setupButton() {
        NSLayoutConstraint.activate([
            faButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            faButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            faButton.heightAnchor.constraint(equalToConstant: 60),
            faButton.widthAnchor.constraint(equalToConstant: 60)
            ])
        faButton.layer.backgroundColor = UIColor.white.cgColor
        faButton.layer.cornerRadius = 30
        faButton.layer.masksToBounds = true
        faButton.layer.borderWidth = 2
        faButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func onAction() {
        loadFav()
        showQuestion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        faButton.isHidden = true
        view.willRemoveSubview(faButton)
    }
    
    @IBAction func onPre(_ sender: Any) {
        if self.topic!.questions!.count == 0 {
            return
        }
        if self.curIndex == 0 {
            self.curIndex = self.topic!.questions!.count
        }
        self.curIndex -= 1
        showQuestion()
    }
    
    @IBAction func onNext(_ sender: Any) {
        if self.topic!.questions!.count == 0 {
            return
        }
        if self.curIndex == self.topic!.questions!.count - 1 {
            self.curIndex = -1
        }
        self.curIndex += 1
        showQuestion()
    }
    
    func showQuestion() {
        if questionContent == nil {
            return
        }
        if self.topic!.questions!.count == 0 {
            questionContent.textColor = .red
            questionContent.text = "No Question In Add. Use add to load"
            return
        } else {
            questionContent.textColor = .black
        }
        let sets = self.topic!.questions!.array as! [Question]
        let question = sets[self.curIndex]
        questionContent.text = question.question
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.setTitle("LIKE", for: .normal)
        self.isCurLike = false
        self.curLikeObject = nil
        for i in userFav {
            if i.question!.objectID.isEqual(question.objectID) {
                likeButton.setTitleColor(.red, for: .normal)
                likeButton.setTitle("UNLIKE", for: .normal)
                self.isCurLike = true
                self.curLikeObject = i
                break
            }
        }
    }
    
    @IBAction func onDoLike(_ sender: Any) {
        if self.topic!.questions!.count == 0 {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let sets = self.topic!.questions!.array as! [Question]
        
        if self.isCurLike {
            managedContext.delete(self.curLikeObject!)
        } else {
            let ques = SaveQuestion(context: managedContext)
            ques.question = sets[self.curIndex]
            ques.topic = self.topic!.topic!
            ques.username = Global.USER_INFO!.username!
            print(ques)
            managedContext.insert(ques)
        }
        
        do {
            try managedContext.save()
            loadFav()
            showQuestion()
        }catch {
            print("Save Failed")
        }
        self.notify?.onAction()
    }
    
}
