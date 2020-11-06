//
//  ViewController.swift
//  medical
//
//  Created by Y YM on 2020/11/3.
//  Copyright © 2020 edu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var email: TextField!
    
    @IBOutlet weak var pswd: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
    }
    
    @IBAction func onNewAccount(_ sender: Any) {
    }
    
    @IBAction func onGuessLogin(_ sender: Any) {
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "username = %@", "_guess")
        userRequest.predicate = predicate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let delegate = appDelegate.persistentContainer.viewContext
        do {
            var allUser = try (delegate.fetch(userRequest))
            print(allUser)
            if allUser.count != 1 {
                for i in allUser {
                    delegate.delete(i)
                }
                let guess = User(context: delegate)
                guess.username = "_guess"
                guess.password = ""
                delegate.insert(guess)
            }
            allUser = try (delegate.fetch(userRequest))
            Global.USER_INFO = allUser[0]
            let guessView = self.storyboard?.instantiateViewController(withIdentifier: "guessController") as! GuessController
            self.present(guessView, animated: true)
        } catch {
            print("Fetch failed")
            return
        }
    }
    
}

