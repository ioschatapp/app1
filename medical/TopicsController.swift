//
//  TopicsController.swift
//  medical
//
//  Created by Y YM on 2020/11/4.
//  Copyright © 2020 edu. All rights reserved.
//


import UIKit

class TopicController: UIViewController {
    
    
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
        print("button tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let view = UIApplication.shared.keyWindow {
            view.addSubview(faButton)
            setupButton()
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
    
}
