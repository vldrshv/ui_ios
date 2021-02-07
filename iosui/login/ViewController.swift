//
//  ViewController.swift
//  iosui
//
//  Created by vlad on 30.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.layer.cornerRadius = 12
        loginText.layer.cornerRadius = 12
        passwordText.layer.cornerRadius = 12
    }
    

    @IBAction func onLoginClicked(_ sender: Any) {
        AnimationUtil.scale(v: loginButton, scaleTo: 0.95)
        
        let login = loginText.text
        let password = passwordText?.text
        print(login)
        print(password)
        
        if login != "v" && password != "v" {
            return // todo show invalid
        } else {
            self.dismiss(animated: false, completion: { self.makeLogin() })
        }
    }
    
    private func makeLogin() {
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BottomTabsController")
        self.present(vc, animated: true, completion: nil)
    }
}

