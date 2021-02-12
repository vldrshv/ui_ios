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
    @IBOutlet weak var errorView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addShadow(to: [loginButton])
        addCornerRadius(to: [loginText, passwordText, loginButton, errorView])
        errorView.isHidden = true
    }
    
    @IBAction func onEditting(_ sender: Any) {
        showError(show: false)
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        AnimationUtil.scale(v: loginButton, scaleTo: 0.95)
        
        let login = loginText.text
        let password = passwordText?.text
        print(login)
        print(password)
        
        if login == "v" && password == "v" {
            self.dismiss(animated: false, completion: { self.makeLogin() })
        } else {
            showError(show: true)
        }
    }
    
    private func makeLogin() {
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BottomTabsController")
        self.present(vc, animated: true, completion: nil)
    }
    
    private func showError(show: Bool) {
        if show && self.errorView.isHidden {
            self.errorView.isHidden = false
        } else {
            if !show && !self.errorView.isHidden {
                self.errorView.isHidden = true
            }
        }
    }
    
    private func addShadow(to: [UIView]) {
        for view in to {
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view.layer.shadowRadius = 15
            view.layer.shadowOpacity = 0.5
            
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    private func addCornerRadius(to: [UIView], cornerRadius: CGFloat = 12) {
        for view in to {
            print("corner")
            view.layer.cornerRadius = cornerRadius
        }
    }
}

