//
//  ThirdViewController.swift
//  GoogleSearchAPIDemo
//
//  Created by wfh on 07/03/20.
//  Copyright © 2020 Harsha. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    var urlSTR: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlSTR ?? "https://www.google.com") {
            let req = URLRequest(url:  url)
            
            webview.load(req)
        }
    }
}
