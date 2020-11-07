//
//  SaveTopicFavCell.swift
//  medical
//
//  Created by Y YM on 2020/11/7.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit

class SaveTopicFavCell: UITableViewCell {

    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var isLike: UISwitch!
    @IBOutlet weak var questionNum: UILabel!
    
    @IBOutlet weak var onDisLike: UISwitch!
    var callback: (()->Void) = {}
    
    var saveTopic: SaveTopics? = nil
    var rawTopic: Topic? = nil
    
    func setTopic(_ st: SaveTopics) {
        saveTopic = st
        rawTopic = st.topic
    }
    
    @IBAction func onDisLike(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        if !isLike.isOn {
            print("On Delete Topic")
            managedContext.delete(saveTopic!)
        } else {
            print("On Save Topic")
            let ques = SaveTopics(context: managedContext)
            ques.topic = rawTopic!
            ques.username = Global.USER_INFO!.username
            
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
