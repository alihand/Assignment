//
//  ViewController.swift
//  Assignment
//
//  Created by Alihan Demir on 24.04.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var num = Int()
    var name = [String]()
    var desc = [String]()
    var subscriptionType = [String]()
    var didUseBefore = [Bool]()
    var price = [Double]()
    var availableUntil = [Int]()
    
    var tariffData = [Int]()
    var tariffSMS = [Int]()
    var tariffTalk = [Int]()
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.dataSource = self
        myTable.delegate = self
        myTable.reloadData()
        
        let filePath = Bundle.main.path(forResource: "packageList", ofType: "json")
        let content = NSData.init(contentsOfFile: filePath!)
        do{
            let dict = try? JSONSerialization.jsonObject(with: content! as Data, options: .mutableContainers)
            print("dict = ",dict!)
            let json = try! JSON(data: content! as Data)
            print("json = ",json)
            
            let jsonArr = json["packages"].array
            num = (jsonArr?.count)!
        
            for i in 0..<num {
                let names = json["packages"][i]["name"].stringValue
                print("name : ",names)
                self.name.append(names)
                
                let desc = json["packages"][i]["desc"].stringValue
                print("desc : ",desc)
                self.desc.append(desc)
                
                let subscriptionType = json["packages"][i]["subscriptionType"].stringValue
                print("subscriptionType : ",subscriptionType)
                self.subscriptionType.append(subscriptionType)
                
                let didUseBefore = json["packages"][i]["didUseBefore"].boolValue
                print("didUseBefore : ",didUseBefore)
                self.didUseBefore.append(didUseBefore)
                
                let price = json["packages"][i]["price"].doubleValue
                print("price : ",price)
                self.price.append(price)
                
                let availableUntil = json["packages"][i]["availableUntil"].intValue
                print("availableUntil",availableUntil)
                self.availableUntil.append(availableUntil)
                
                let tariffData = json["packages"][i]["tariff"]["data"].intValue
                print("tariff Data",tariffData)
                self.tariffData.append(tariffData)
                
                let tariffSms = json["packages"][i]["tariff"]["sms"].intValue
                print("tariff SMS",tariffSms)
                self.tariffSMS.append(tariffSms)
                
                let tariffTalk = json["packages"][i]["tariff"]["talk"].intValue
                print("tariff Talk",tariffTalk)
                self.tariffTalk.append(tariffTalk)
                
            }
        }
    }
    
    func sortOption(){
        tariffSMS.sort{
            return $0 < $1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyTableViewCell = myTable.dequeueReusableCell(withIdentifier: "package") as! MyTableViewCell
        
        cell.lblName.text! = name[indexPath.row]
        cell.lblDesc.text! = desc[indexPath.row]
        cell.lblSubscriptionType.text! = subscriptionType[indexPath.row]
        cell.lblDidUseBefore.text! = String(didUseBefore[indexPath.row])
        cell.lblPrice.text! = String(price[indexPath.row])
        cell.lblTariffData.text! = String(tariffData[indexPath.row])
        cell.lblTariffTalk.text! = String(tariffTalk[indexPath.row])
        cell.lblTariffSMS.text! = String(tariffSMS[indexPath.row])
        
        return cell
    }
    
    
}

