//
//  ViewController.swift
//  iosui
//
//  Created by vlad on 30.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rootContainer: UIView!
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordContainer: UIView!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        addSpacing(to: [loginText, passwordText])
        addShadow(to: [loginContainer, passwordContainer], radius: 10, opacity: 0.15)
        addShadow(to: [loginButton])
        addCornerRadius(to: [loginContainer, loginText, passwordContainer, passwordText, loginButton, errorView])
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
    
    private func addSpacing(to: [UITextField]) {
        
        for textField in to {
            let spaceView = UIView(frame:
                CGRect(x: 0, y: 0, width: 16, height: textField.frame.height)
            )
            textField.leftView = spaceView
            textField.leftViewMode = UITextField.ViewMode.always
            
//            textField.rightView = spaceView
//            textField.rightViewMode = UITextField.ViewMode.always
        }
    }
    
    private func addShadow(to: [UIView], radius: CGFloat = 10, opacity: Float = 0.3) {
        for view in to {
            
            view.clipsToBounds = true
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = radius
            view.layer.shadowOpacity = opacity
            
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

