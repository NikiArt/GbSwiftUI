//
//  LoginController.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 15.01.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import UIKit
import WebKit

class LoginController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Api.shared.appId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        //let request = URLRequest(url: urlComponents.url!)
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
        view = webView
    }

}

extension LoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //decisionHandler(.allow)
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        let token = params["access_token"]
        let userId = params["user_id"]
        ConnectingPref.shared.token = token ?? ""
        ConnectingPref.shared.userId = userId ?? ""
        print(token)
        print(userId)
        Api.shared.getUserGroupsList()
        Api.shared.getFriendsList()
        //Api.shared.getUserPhotos()
        //Api.shared.searchGroups(searchString: "swift")

        let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabBarContrl") as UIViewController
        self.show(nextViewController, sender: self)
        decisionHandler(.cancel)
    }
}
