//
//  SaveQuestionCell.swift
//  medical
//
//  Created by Y YM on 2020/11/7.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit

class SaveQuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionContent: UILabel!
    @IBOutlet weak var isLike: UISwitch!
    var questionItem: SaveQuestion? = nil
    var topic: String? = nil
    var rawQuestion: Question? = nil
    var callback: (()->Void) = {}
    
    
    func setQuestion(_ question: SaveQuestion) {
        questionItem = question
        rawQuestion = question.question
        topic = question.topic
    }
    
    
    @IBAction func onDislike(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        if !isLike.isOn {
            managedContext.delete(questionItem!)
        } else {
            let ques = SaveQuestion(context: managedContext)
            ques.topic = topic!
            ques.question = rawQuestion
            ques.username = Global.USER_INFO!.username!
            managedContext.insert(ques)
        }
        do {
            try managedContext.save()
        }catch {
            print("Save Failed")
        }
        callback()
    }
    
}
