//
//  BrowserViewController.swift
//  GourMemo
//
//  Created by Miku Shimizu on 2017/03/03.
//  Copyright © 2017年 Miku Shimizu. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class BrowserViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    var webView: WKWebView!
    
    var requestedUrl: String = ""
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // WKWebViewを生成
        let y = statusbarHeight + navigationbarHeight
        webView = WKWebView(frame:CGRect(x: 0, y: y, width: self.view.bounds.size.width, height: self.view.bounds.size.height - y - toolbarHeight))
        
        // フリップで進む・戻るを許可
        webView.allowsBackForwardNavigationGestures = true
        
        // 表示
        let urlString = requestedUrl
        let url = NSURL(string: urlString)
        let request = NSURLRequest(url: url! as URL)
        webView.load(request as URLRequest)
        
        // Viewに貼り付け
        self.view.addSubview(webView)
        
    }
    
    @IBAction func back() {
        self.webView.goBack()
    }
    
    @IBAction func forward() {
        self.webView.goForward()
    }
    
    @IBAction func like() {
        let addToRealm = FavoriteRestaurant()
        
        // optional binding
        if let url = self.webView.url {
            addToRealm.url = String(describing: url)
            
            try! realm.write {
                realm.add(addToRealm)
            }
        }
        
        
        
    }
    
    @IBAction func done(){
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
