//
//  LoginViewController.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }

    private let api: VkApiProtocol = VkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = api.getUrl(method: .auth, userId: nil) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func makeLogin() {
        let sb = UIStoryboard(name: "BottomTabs", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BottomTabsController")
        self.present(vc, animated: true, completion: nil)
    }
}

extension LoginViewController : WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        api.setSessionFrom(fragment) { self.makeLogin() }
            
        decisionHandler(.cancel)
    }
}
