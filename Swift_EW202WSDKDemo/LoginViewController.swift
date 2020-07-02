//
//  LoginViewController.swift
//  Swift_TWPSDKDemo
//
//  Created by San on 12/6/2020.
//  Copyright © 2020 medica. All rights reserved.
//

import UIKit
import SLPTCP
import SLPCommon

class LoginViewController: UIViewController {
    
    @IBOutlet weak var urlTextfield: UITextField!
    @IBOutlet weak var tokenTextfield: UITextField!
    @IBOutlet weak var channelidTextfield: UITextField!
    @IBOutlet weak var connectBT: UIButton!
    @IBOutlet weak var deviceIdTextfield: UITextField!
    @IBOutlet weak var versionTextfield: UITextField!
    @IBOutlet weak var upgradeBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
        
        self.urlTextfield.text = "http://172.14.0.111:8082";
        self.channelidTextfield.text = "13700"
        self.tokenTextfield.text = "kylhm2tu62sw"
        self.deviceIdTextfield.text = "EW22W20C00044";
        
        
    }
    //    self.channelidTextfield.text
    func initUI() -> Void {
        self.connectBT.layer.cornerRadius = 2.0;
        self.connectBT.layer.masksToBounds = true;
        self.upgradeBT.layer.cornerRadius = 2.0;
        self.upgradeBT.layer.masksToBounds = true;
    }
    
    @IBAction func connect(_ sender: Any) {
        var dictionary = Dictionary<String, String>();
        dictionary = ["url": self.urlTextfield.text!, "channelID":self.channelidTextfield.text!]

        SLPHTTPManager.sharedInstance().initHttpServiceInfo(dictionary);
        
        SLPHTTPManager.sharedInstance().authorize(self.tokenTextfield.text!, timeout: 0, completion: { (status: Bool, json: Any?, error: String) in
            if status == true
            {
                let dic = json as? [String: Any?];
                                
                let data = dic?["data"] as? [String: Any?];
                
                let tcpServer = data?["tcpServer"] as? [String : String];
                let ip = tcpServer?["ip"];
                let port = Int((tcpServer?["port"]!)!);
                
                SLPLTcpManager.sharedInstance()?.loginHost(ip, port: port!, deviceID: self.deviceIdTextfield.text!, token: self.tokenTextfield.text!, completion: { (status: Bool) in
                    if status == true
                    {
                        print("login succeed")
                    }
                    else
                    {
                        print("login failed")
                    }
                })
            }
            else
            {
                print("init failed")
            }
        })
    }
    
    @IBAction func upgrade(_ sender: Any) {
        SLPLTcpManager.sharedInstance()?.publicUpdateOperation(withDeviceID: self.deviceIdTextfield.text!, deviceType: SLPDeviceTypes.EW202W, firmwareType: 1, firmwareVersion: UInt16(self.versionTextfield.text!)!, timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?) in
            
            if status == SLPDataTransferStatus.succeed
            {
                NotificationCenter.default.addObserver(self, selector: #selector(self.receive_notifaction(notify:)), name: Notification.Name(kNotificationNameTCPDeviceUpdateRateChanged), object: nil)
            }
            else
            {
                print("upgrade failed")
            }
        })
        
    }
    
    
    @objc func receive_notifaction(notify: NSNotification) -> Void {
        
        let progressInfo: SLPLTcpUpgradeInfo = notify.userInfo?[kNotificationPostData] as! SLPLTcpUpgradeInfo
        
        print("progress:\(progressInfo.rate)" + "%")
        
    }
    
    @IBAction func bind(_ sender:Any){
        
        SLPHTTPManager.sharedInstance().bindDevice(withDeviceId: self.deviceIdTextfield.text!, userID: "", timeOut: 10.0, completion: { (status: Bool, data: Any?,  error: String) in
            if status == true
            {
                print("bind succeed")
            }
            else
            {
                print("bind failed")
            }
            
        })
    }
    

    @IBAction func unbind(_ sneder:Any){

        SLPHTTPManager.sharedInstance().unBindDevice(withDeviceId: self.deviceIdTextfield.text!, userID: "", timeOut: 10.0, completion: { (status: Bool,  error: String) in
            if status == true
            {
                print("unbind succeed")
            }
            else
            {
                print("unbind failed")
            }
        })
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignTextfiled()
    }
    
    func resignTextfiled() -> Void {
        
        self.urlTextfield.resignFirstResponder()
        self.tokenTextfield.resignFirstResponder()
        self.channelidTextfield.resignFirstResponder()
        self.deviceIdTextfield.resignFirstResponder()
        self.versionTextfield.resignFirstResponder()
    }
}
