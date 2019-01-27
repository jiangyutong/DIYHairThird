//
//  LoginController.swift
//  Animate
//
//  Created by Mac on 17/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import LeanCloud
class LoginController: BaseViewController,CBGroupAndStreamViewDelegate {
    var islogin=false;
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var backbtn: UIButton!
    var imagenames=["HeadPortrait1","HeadPortrait2","HeadPortrait3","HeadPortrait4","HeadPortrait5","HeadPortrait6","HeadPortrait7"]
    
    
    @IBOutlet weak var tips: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var buttonAdress: UIButton!
    //    let button2: UIButton = {
    //        let button = UIButton(frame: CGRect(x: 100, y: 450, width: UIScreen.main.bounds.width - 200, height: 50))
    //        button.addTarget(self, action: #selector(onClickSelectButton), for: .touchUpInside)
    //        button.setTitleColor(UIColor(red: 255/255, green: 51/255, blue: 102/255, alpha: 1), for: .normal)
    //        button.setTitle("选择地址", for: .normal)
    //        return button
    //    }()
    var labGroup = CBGroupAndStreamView()
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var button: PQButton!
    var mytype:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resetBut = UIButton.init(type: .custom)
        resetBut.setTitle("重置", for: .normal)
        resetBut.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        resetBut.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetBut.setTitleColor(UIColor.brown, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: resetBut)
        resetBut.addTarget(self, action: #selector(resetLabGroup), for: .touchUpInside)
        
        let confirmBut = UIButton.init(type: .custom)
        confirmBut.setTitle("确定", for: .normal)
        confirmBut.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        confirmBut.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        confirmBut.setTitleColor(UIColor.brown, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: confirmBut)
        confirmBut.addTarget(self, action: #selector(confirmLabGroup), for: .touchUpInside)
        
        let titleArr = [" "]
        let contentArr = [["理发师","顾客"]]
        
        labGroup = CBGroupAndStreamView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 400))
        labGroup.titleTextFont = .systemFont(ofSize: 14)
        labGroup.titleLabHeight = 30;
        labGroup.titleTextColor = .blue
        labGroup.isSingle = true
        //        labGroup.defaultSelIndex = 1
        //        labGroup.defaultSelSingleIndeArr = [1,1,0,0]
        //使用该参数则默认为多选 isSingle 无效 defaultSelSingleIndeArr 设置无效
        labGroup.defaultSelIndexArr = [[0,5,8,3,2],1,0,3]
        //分别设置每个组的单选与多选
        labGroup.defaultGroupSingleArr = [1]
        labGroup.setDataSource(contetnArr: contentArr, titleArr: titleArr)
        labGroup.delegate = self
        self.view.addSubview(labGroup)
        labGroup.confirmReturnValueClosure = {
            (selArr,groupIdArr) in
            //            print(selArr)
        }
        labGroup.currentSelValueClosure = {
            (valueStr,index,groupId) in
            self.mytype=String(index)
            print("\(valueStr) index = \(index), groupid = \(groupId)")
        }
        
        startTimer()
        buttonAdress.addTarget(self, action: #selector(onClickSelectButton), for: .touchUpInside)
        //button.touchUpInSideEvent()
        
        //        button.touchUpInSideEvent{ (button) in
        //            print("点击了我")
        //
        //
        //                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
        //                    //                button.isStopLoginingAni = true
        //                    let controller = LoginSuccessController()
        //                    controller.transition.animationType = PQTransitionType(rawValue: self.animationType)!
        //                    self.present(controller, animated: true, completion: nil)
        //                })
        //
        //
        //
        //        }
        //        button.touchUpInSideEvent(shifou: islogin) { (button) in
        //            print("点击了我")
        //
        //
        //                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
        //                    //                button.isStopLoginingAni = true
        //                    let controller = LoginSuccessController()
        //                    controller.transition.animationType = PQTransitionType(rawValue: self.animationType)!
        //                    self.present(controller, animated: true, completion: nil)
        //                })
        //
        //
        //
        //            //模仿登录失败/成功
        //
        //        }
        //
       
        self.view.addSubview(label)
        self.view.addSubview(buttonAdress)
        self.view.bringSubview(toFront:backbtn)
    }
    
    func currentSelValueWithDelegate(valueStr: String, index: Int, groupId: Int) {
        print("\(valueStr) index = \(index), groupid = \(groupId)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.isStopLoginingAni = true
    }
    @objc func resetLabGroup(){
        labGroup.reload()
    }
    
    @objc func confirmLabGroup(){
        labGroup.comfirm()
    }
    @objc fileprivate func chageBackImg(){
        //rippleEffect rippleEffect
        let transitionAni = Animate.transitionAnimationWith(duration: 1.25, type: "rippleEffect", subtype: nil, startProgress: 0, endProgress: 1)
        backImageView.image = UIImage(named: imgNamed)
        backImageView.layer.add(transitionAni, forKey: "rippleEffect")
        
        imgNamed = (imgNamed == "bizhi") ? "bizhi2" : "bizhi"
    }
    
    lazy var animationType : Int = 0
    @IBAction func chioseAnimationType(_ sender: UISegmentedControl) {
        animationType = sender.selectedSegmentIndex
    }
    
    @objc func onClickSelectButton(){
        let addressPicker = EWAddressViewController()
        /*** 可使用这种init方法自定制选中颜色,不填写selectColor默认颜色为UIColor(red: 79/255, green: 176/255, blue: 255/255, alpha: 1),蓝色
         let addressPicker = EWAddressViewController(selectColor: UIColor.yellow)
         */
        // 返回选择数据,地址,省,市,区
        addressPicker.backLocationStringController = { (address,province,city,area) in
            self.label.text = address
            print(address)
        }
        self.present(addressPicker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(){
        changImgTimer = createTimer()
    }
    
    func createTimer() -> Timer{
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(chageBackImg), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        return timer
    }
    
    @IBAction func islogin(_ sender: Any) {
        let a = Int(arc4random()%7)
        var img=UIImage(named: self.imagenames[a])
        let data=UIImagePNGRepresentation(img!)
        if let type=self.mytype,let username=self.username.text,let password=self.password.text,let email=self.email.text,let adress = self.label.text
        {
            
            
            if(validateEmail(email: email) == true)
            {
                islogin=true
            }
            
            
            //            print(self.mytype)
            //            print(self.username.text)
            //            print(self.password.text)
            //            print(self.email.text)
            //            print(self.label.text)
        }
        //        else
        //        {
        //            print(self.mytype)
        //            print(self.username.text)
        //            print(self.password.text)
        //            print(self.email.text)
        //            print(self.label.text)
        //        }
        if(islogin==true)
        {
            button.touchUpInSideEvent { (button) in
                print("点击了我")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                    let randomUser = LCUser()
                    
                    randomUser.username = LCString(self.username.text!)
                    randomUser.password = LCString(self.password.text!)
                    randomUser.email=LCString(self.email.text!)
                    randomUser.signUp()
                    LCUser.logIn(username: self.username.text!, password: self.password.text!) { result in
                        switch result {
                        case .success(let user):
                            let file=AVFile(data: data!)
                            let obj=AVObject(className: "myuser")
                            obj.setObject(file, forKey: "image")
                            obj.setObject(self.username.text!, forKey: "username")
                            obj.setObject(self.password.text!, forKey: "password")
                            obj.setObject(self.label.text!, forKey: "email")
                            obj.setObject(self.mytype, forKey: "type")
                            obj.saveInBackground({ (resultbool, error) in
                                if(resultbool){
                                    print("cg****************")
                                }else{
                                    print("sb****************")
                                }
                            })
                            let obj2=AVObject(className: "Sharingexperience")
                            obj2.setObject(file, forKey: "image")
                            obj2.setObject(self.username.text!, forKey: "username")
                            obj2.saveInBackground({ (resultbool, error) in
                                if(resultbool){
                                    print("cg2****************")
                                }else{
                                    print("sb2****************")
                                }
                            })
                            let currentUser = LCUser.current!
                            
                            currentUser.set("adrees", value:self.label.text!)
                            currentUser.set("type", value:self.mytype)
                            currentUser.save { result in
                                switch result {
                                case .success:
                                    break
                                case .failure(let error):
                                    print(error)
                                }
                            }
                            break
                        case .failure(let error):
                            print(error)
                        }
                    }
                    //                button.isStopLoginingAni = true
                    self.tips.text=""
                    let controller = LoginSuccessController()
                    controller.transition.animationType = PQTransitionType(rawValue: self.animationType)!
                    self.present(controller, animated: true, completion: nil)
                })
                
                
            }
            
        }
        else
        {
            tips.text="信息未填完整哟"
            print("信息未填完整")
        }
    }
    
    lazy var changImgTimer : Timer = Timer()
    var imgNamed : String = "bizhi2"
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
        
    }
    
    @IBAction func back(_ sender: Any) {
        print("back******")
        let controller = StartViewController()
        self.present(controller, animated: true, completion: nil)
    }
}
