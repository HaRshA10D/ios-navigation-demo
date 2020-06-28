//
//  SecondViewController.swift
//  NavigationDemo
//
//  Created by Harsha Vardhan Dharmavarapu on 28/06/20.
//  Copyright © 2020 Harsha Vardhan Dharmavarapu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    private lazy var button: UIButton = {
        
        let button = UIButton(type: .infoLight)
        button.setTitle("Switch First screen color", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        view.addToCenter(view: button)
        
        button.addTarget(self, action: #selector(notifyScreenColorSwitch), for: .touchUpInside)
    }
    
    @objc private func notifyScreenColorSwitch() {
            
        DispatchQueue.global(qos: .background).async {
            
            print("While button: ", Thread.isMainThread)
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "ColourSwitch")))
        }
    }
}
