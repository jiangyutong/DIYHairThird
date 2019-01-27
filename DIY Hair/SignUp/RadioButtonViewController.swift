//
//  RadioButtonViewController.swift
//  DIY Hair
//
//  Created by jiangyutong on 2019/1/19.
//  Copyright © 2019 blueGrey. All rights reserved.
//

import UIKit

class RadioButtonViewController: UIViewController {
    var labGroup = CBGroupAndStreamView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 程序会根据frame.height的值设置字体的大小，所以不能为0
        
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
        
        let titleArr = [""]
        let contentArr = [["理发师","顾客"]]
        
        labGroup = CBGroupAndStreamView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width-200, height: UIScreen.main.bounds.size.height))
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
            //            print("\(valueStr) index = \(index), groupid = \(groupId)")
        }
        
    }
    
    @objc func resetLabGroup(){
        labGroup.reload()
    }
    
    @objc func confirmLabGroup(){
        labGroup.comfirm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RadioButtonViewController : CBGroupAndStreamViewDelegate{
    
    func currentSelValueWithDelegate(valueStr: String, index: Int, groupId: Int) {
        print("\(valueStr) index = \(index), groupid = \(groupId)")
    }
    
    func confimrReturnAllSelValueWithDelegate(selArr: Array<Any>, groupArr: Array<Any>) {
        print(selArr)
    }
}

