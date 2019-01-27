//
//  MoreViewController.swift
//  DIY Hair
//
//  Created by jiangyutong on 2019/1/19.
//  Copyright © 2019 blueGrey. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var myUIview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let filePath = Bundle.main.path(forResource: "timg", ofType: "gif")
        
        let filePath = Bundle.main .path(forAuxiliaryExecutable: "timg8.gif")
        
        let gif = NSData(contentsOfFile: filePath!)
        let webViewBG = UIWebView(frame: self.view.frame)
        
        webViewBG.load(gif! as Data, mimeType: "image/gif", textEncodingName: String(), baseURL: NSURL() as URL)
        
        webViewBG.isUserInteractionEnabled = false;
        
        self.view.addSubview(webViewBG)
        let filter = UIView()
        
        filter.frame = self.view.frame
        
        filter.backgroundColor = UIColor.white
        
        filter.alpha = 0.2
        view.addSubview(filter)
        self.view.bringSubview(toFront: myUIview)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
//    @IBAction func siginup(_ sender: Any) {
//     //let ratingVC = RaingViewController()
//        present(LoginController(), animated: true, completion: nil)
//    }
}


