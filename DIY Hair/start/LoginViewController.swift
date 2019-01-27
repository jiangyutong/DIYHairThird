//
//  LoginViewController.swift
//  myfistlib
//
//  Created by student on 2018/12/23.
//  Copyright © 2018年 蒋宇童. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloudIM
import Alamofire
class LoginViewController: UIViewController, UITextFieldDelegate{
    var token=""
    @IBOutlet weak var headimage: UIImageView!
    var btn: DKTransitionButton!
    var image=["HeadPortrait1","HeadPortrait2"]
    
    // @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var goLB: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var imgview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var image1=UIImage(named:image[0])
        headimage.image=image1
        startAnimation()
        headimage.layer.cornerRadius=headimage.frame.size.height/2
        headimage.clipsToBounds=true
        passwordTF.delegate=self
        userTF.delegate=self
        passwordTF.isSecureTextEntry = true
        passwordTF.returnKeyType = UIReturnKeyType.done
        userTF.returnKeyType = UIReturnKeyType.done
        btn = DKTransitionButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 100, height: 44))
        btn.backgroundColor = UIColor(red: 1, green: 0, blue: 128.0 / 255.0, alpha: 0.6)
        btn.center = self.view.center
        btn.frame.bottom = self.view.frame.height - 100
        btn.setTitle("Sign in", for: [])
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: UIControlEvents.touchUpInside)
      //  btn.addTarget(self, action: #selector(onTapButton(_:)), for: UIControl.Event.touchUpInside)
        btn.spiner.spinnerColor = UIColor.white
//        textFieldShouldReturn(passwordTF)
//        textFieldShouldReturn(userTF)
        
        let filter = UIView()
        
        filter.frame = self.view.frame
        
        filter.backgroundColor = UIColor.black
        filter.alpha = 0.2
        view.addSubview(filter)
        self.view.bringSubview(toFront: myview)
        self.view.addSubview(btn)
        imgview.image=UIImage(named: "login3")
        userTF.alpha=0.5
        passwordTF.alpha=0.5
        goLB.alpha=0.5
        //btn2.layer.cornerRadius=10
        passwordTF.isSecureTextEntry=true
        // Do any additional setup after loading the view.
    }
    
    func startAnimation(){
        
        //Scale
        let scaleAnimate = Animate.baseAnimationWithKeyPath("transform.scale", fromValue: nil, toValue: 1.2, duration: 1.5, repeatCount: Float.infinity, timingFunction: nil)
        scaleAnimate.autoreverses = true
       headimage.layer.add(scaleAnimate, forKey: "transform.scale")
        
       
    }
 
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    /*   @IBAction func isLogin(_ sender: UIButton) {
     if passwordTF.text=="admin"&&userTF.text=="admin" as String as String
     {
     self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
     }
     }*/
    @IBAction func onTapButton(_ button: DKTransitionButton) {
        
        // 开始加载动画
        button.startLoadingAnimation()
//        let query = LCQuery(className: "Todo")
//        if passwordTF.text != ""&&userTF.text != ""{
//            // 成功，进行界面切换
//            let username=userTF.text!
//            query.whereKey("username", .equalTo(username))
//        } else {
//            // 失败返回并提示
//            button.startShakeAnimation(1, completion: {
//                // 提示登录失败
//                print("badend")
//            })
//        }
      
    
        
        LCUser.logIn(username: userTF.text!, password: passwordTF.text!) { result in
            switch result {
            case .success(let user):
                self.requestToken1(userID:self.userTF.text!)
                button.startSwitchAnimation(1, completion: { [unowned self]() -> () in
             
                    let m=MyMoreViewController()
                  
                    self.navigationController?.pushViewController(m, animated: true)
                    //navigationController?.pushViewController(chat!, animated: true)
                    //self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
                })
               
                break
            case .failure(let error):
               
                button.startShakeAnimation(1, completion: {
                    // 提示登录失败
                    print("badend")
                })
                print(error)
            }
        }


//        if passwordTF.text=="admin"&&userTF.text=="admin" as String as String {
//            // 成功，进行界面切换
//            button.startSwitchAnimation(1, completion: { [unowned self]() -> () in
//                self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
//            })
//
//
//        } else {
//            // 失败返回并提示
//
//
//            button.startShakeAnimation(1, completion: {
//                // 提示登录失败
//                print("badend")
//            })
//        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("jyt")
        if let username=userTF.text
        {
            startAnimation()
            let  query=AVQuery(className: "myuser")
            query.whereKey("username", equalTo: username)
            let temp=query.findObjects() as! [AVObject]
            if(temp.count>0)
            {
                let U=temp[0]["image"] as! AVFile
                self.headimage.image=UIImage(data: U.getData()!)
            }
//            let  query = LCQuery(className: "myuser")
//            query.whereKey("username", .equalTo(username))
//            query.find { result in
//                switch result {
//                case .success(let todos):
//                    // 每一页 10 条数据，跳过了 20 条数据，因此获取的是第 3 页的数据
//                     print("great")
//                    guard let todo = todos.first else { return }
//                    let U=todo.get("image") as! AVFile
//                    self.headimage.image=UIImage(data: U.getData()!)
//
//                case .failure(let error):
//                    print(error)
//                }
//            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func change(_ sender: Any) {
        if(passwordTF.isSecureTextEntry == true)
        {
            print("hhhhh********")
            passwordTF.isSecureTextEntry = false
           
        }
        else
        {
             print("ccc********")
            passwordTF.isSecureTextEntry = true
        }
    }
    
        func requestToken1(userID:String) -> Void {
            let dicUser = ["userId":userID,
                           "name":userID,
                           "portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
            ] //请求token的用户信息
            let urlStr = "https://api.cn.ronghub.com/user/getToken.json" //网址接口
            let appKey = "kj7swf8ok3ht2"
            let appSecret = "d90NwSZPS6YU"
            let nonce = "\(arc4random())"   //生成随机数
            let timestamp = "\(NSDate().timeIntervalSince1970)"//时间戳
            var sha1Value = appSecret + nonce + timestamp
            sha1Value = sha1Value.sha1()//数据签名,sha1是一个加密的方法
            let headers = [ //照着文档要求写的Http 请求的 4个head
                "App-key":appKey
                ,"Nonce":nonce
                ,"Timestamp":timestamp
                ,"Signature":sha1Value
            ]
            Alamofire.request(urlStr, method: .post, parameters: dicUser , encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                print(response)
                if let dic = response.result.value  as? NSDictionary{
                    let code = dic.value(forKey: "code") as! NSNumber
                    if code.stringValue == "200" {
                        print(dic.value(forKey: "token"))
                        self.token=dic.value(forKey: "token") as! String
    
                        print("sadfasf  "+self.token)
                        self.ConnectOne()
                    }
                }
            }
        }
    
        func ConnectOne()->Void{
            RCIM.shared().initWithAppKey("kj7swf8ok3ht2")
    
    
            RCIM.shared().connect(withToken: token,success: { (userId) -> Void in
                print("登陆成功。当前登录的用户ID：\(userId)")
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
            })
    
        }
}

