//
//  OptionsController.swift
//  medical
//
//  Created by Y YM on 2020/11/4.
//  Copyright © 2020 edu. All rights reserved.
//


import UIKit

class OptionsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func showAbout(_ sender: Any) {
        let alert = UIAlertController(title: "About", message: "Use this app to search for questions you'd like to save and ask later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showVersion(_ sender: Any) {
        let alert = UIAlertController(title: "Version", message: "Version 1.0.1. Powered at 2020/11/01", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
