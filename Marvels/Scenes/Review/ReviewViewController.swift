//
//  ReviewViewController.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 19.08.2021.
//

import UIKit
import WebKit

class ReviewViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var getUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        review()
        print(getUrl)

    }
    
  
    
    func review() {
        if let url = URL(string: self.getUrl) {
            webView.load(URLRequest(url: url))
        }
    }

}


