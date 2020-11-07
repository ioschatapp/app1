//
//  TopicDetailsController.swift
//  medical
//
//  Created by Y YM on 2020/11/6.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit

class TopicDetailsController: UISimpleSlidingTabController {
    
    var topic: Topic? = nil
    
    var browseView: BrowseController? = nil
    var savedView: SavedQuestionController? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        browseView!.setTopic(topic: topic!)
        savedView!.setTopic(topic: topic!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        
        navigationItem.title = "Topic Details"
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barStyle = .black
        
        savedView = self.storyboard?.instantiateViewController(withIdentifier: "savedQuestionController") as? SavedQuestionController
        browseView = self.storyboard?.instantiateViewController(withIdentifier: "browseQuestionController") as? BrowseController
        
        savedView!.notify = browseView
        browseView!.notify = savedView
//        let commView = self.storyboard?.instantiateViewController(withIdentifier: "communityQuestionController") as! UITableViewController
        browseView!.setTopic(topic: topic!)
        savedView!.setTopic(topic: topic!)
        
        addItem(item: savedView!, title:  "  SAVED  ")
        addItem(item: browseView!, title: " BROWSE  ")
//        addItem(item: commView, title:   "COMMUNITY")
        setHeaderActiveColor(color: .orange)
        setHeaderInActiveColor(color: .black)
        setHeaderBackgroundColor(color: .white)
        setStyle(style: .fixed)
        build()
    }
    
    func setTopic(topic: Topic) {
        self.topic = topic
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

