//
//  FoodType1TableViewController.swift
//  myfistlib
//
//  Created by student on 2018/12/24.
//  Copyright © 2018年 蒋宇童. All rights reserved.
//

import UIKit

class FoodTypeTableViewController: UITableViewController {
    //美食类别
    let foodtype = ["热门专题","口味特色","汤粥主食","蛋奶豆制品","蔬菜水果","肉类","水产","烘焙甜品饮料"]
    //选择的美食
    var food : Food?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册FoodTypeTableViewCell
        let nib = UINib(nibName: "FoodTypeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "foodTypeCell")
        //取消tableView多余的横线
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initializeUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    //界面初始化
    func initializeUserInterface() {
        //设置标题
        self.title = "美食"
        //设置tableview背景颜色
        self.tableView.backgroundColor = UIColor(red: 254/255.0, green: 248/255.0, blue: 245/255.0, alpha: 1)
        //这里修改图片颜色，使得图片和原图颜色一致
        self.tabBarItem.image = UIImage(named: "food")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: "food_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //这里修改字体颜色  foregroundColor -> 字体颜色   font: UIFont(name: "Heiti SC", size: 24.0) -> 修改字体
        let attributes =  [NSAttributedString.Key.foregroundColor: UIColor(red: 243/255.0, green: 186/255.0, blue: 99/255.0, alpha: 1.0),
                           NSAttributedString.Key.font: UIFont(name: "Heiti SC", size: 24.0)!]
        self.tabBarItem.setTitleTextAttributes(attributes, for: UIControl.State.selected)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodtype.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodTypeCell", for: indexPath) as! FoodTypeTableViewCell
        cell.lbType1.text = foodtype[indexPath.row]
        cell.imgView.image = UIImage(named: "foodImg\(indexPath.row + 1).jpg")
        cell.imgView.contentMode = .scaleAspectFit
        let labels = labelName(foodType: foodtype[indexPath.row])
        cell.lbFoodLabel1.text = labels[0]
        cell.lbFoodLabel2.text = labels[1]
        cell.lbFoodLabel3.text = labels[2]
        return cell
    }
    //let foodtype = ["热门专题","口味特色","汤粥主食","蛋奶豆制品","蔬菜水果","肉类","水产","烘焙甜品饮料"]
    func labelName(foodType : String) -> [String] {
        switch foodType {
        case "热门专题":
            return ["功效","人群","菜式"]
        case "口味特色":
            return ["口味","异国风味","烹饪方法"]
        case "汤粥主食":
            return ["饼","汤羹","面"]
        case "蛋奶豆制品":
            return ["蛋类","奶制品","豆制品"]
        case "蔬菜水果":
            return ["蔬菜","水果","菌菇类"]
        case "肉类":
            return ["鸡","牛","羊"]
        case "水产":
            return ["螃蟹","虾","贝"]
        default:
            return ["甜品","烘焙","饮品"]
        }
        
    }
    
    //选择某个cell时
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //设置反弹
        self.tableView!.deselectRow(at: indexPath, animated: true)
        //创建food
        self.food = Food(foodType: foodtype[indexPath.row], foodDes: "", foodCpName: "", foodLargeImgName: "")
        //创建跳转页面的VC
        let foodTableViewController = FoodTableViewController.init(nibName: "FoodTableViewController", bundle: Bundle.main)
        //传值
        foodTableViewController.food = self.food
        //跳转
        self.navigationController?.pushViewController(foodTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
