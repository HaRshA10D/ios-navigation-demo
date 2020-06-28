//
//  ViewController.swift
//  NavigationDemo
//
//  Created by Harsha Vardhan Dharmavarapu on 09/06/20.
//  Copyright © 2020 Harsha Vardhan Dharmavarapu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    private lazy var button: UIButton = {
        
        let button = UIButton(type: .infoLight)
        button.setTitle("Go to second screen", for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        
        return button
    }()
    
    private var isBlueBackground: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
        
        view.addToCenter(view: button)
        
        button.addTarget(self, action: #selector(goToSecondController), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(colourSwitch), name: Notification.Name(rawValue: "ColourSwitch"), object: nil)
    }
    
    @objc private func goToSecondController() {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    @objc private func colourSwitch() {
        
        print(Thread.isMainThread)
        
        if Thread.isMainThread {
            switchColour()
        } else {
            DispatchQueue.main.async { [weak self] in
                
                self?.switchColour()
            }
        }
    }
    
    private func switchColour() {
        if self.isBlueBackground {
            self.view.backgroundColor = .brown
        } else {
            self.view.backgroundColor = .blue
        }
        
        self.isBlueBackground.toggle()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIView {
    
    func addToCenter(view: UIView) {
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

