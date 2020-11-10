//
//  GuessController.swift
//  medical
//
//  Created by Y YM on 2020/11/4.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit

class GuessController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    
    var tutorialNum = 0
    
    let labels = [
        "",
        "Use this app to search for questions you'd like to save and ask later.",
        "Your can also create your own questions and post them for you or others to use. Click NEXT to get started!"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onNextTutorial(_ sender: Any) {
        if (tutorialNum == labels.count - 1) {
            let homeView = self.storyboard?.instantiateViewController(withIdentifier: "homeBaseController") as! UIViewController
            homeView.modalPresentationStyle = .fullScreen
            self.present(homeView, animated: true)
        } else {
            tutorialNum += 1
            labelText.text = labels[tutorialNum]
        }
    }
    
    @IBAction func onEndTutorial(_ sender: Any) {
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "homeBaseController") as! UIViewController
        homeView.modalPresentationStyle = .fullScreen
        self.present(homeView, animated: true)
    }
    
    
}
