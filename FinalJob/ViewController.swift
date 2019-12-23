//
//  ViewController.swift
//  NJU
//
//  Created by naive on 2019/12/23.
//  Copyright © 2019 linnaXie. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKUIDelegate{
    
    
    @IBOutlet weak var webView: WKWebView!
    var nowURL:String?
    
    override func loadView() {
        
        //配置网页视图
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myURL = URL(string: "https://hr.nju.edu.cn"+nowURL!){
            print("sdas")
            print(myURL)
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }

}
