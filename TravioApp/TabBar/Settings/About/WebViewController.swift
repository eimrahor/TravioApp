//
//  WebViewController.swift
//  TravioApp
//
//  Created by Kurumsal on 12.09.2023.
//

import UIKit
import WebKit
import SnapKit

enum Links: String {
    case termsofUse = "https://api.iosclass.live/terms"
    case about = "https://api.iosclass.live/about"
}

class WebViewController: UIViewController, WKNavigationDelegate  {
    
    private lazy var wView: UIView = {
        let v = UIView()
        return v
    }()
    
    var webView: WKWebView!
    var url: Links?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = url?.rawValue else { return }
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}
