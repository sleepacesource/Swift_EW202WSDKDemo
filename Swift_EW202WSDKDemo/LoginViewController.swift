//
//  LoginViewController.swift
//  Swift_TWPSDKDemo
//
//  Created by San on 12/6/2020.
//  Copyright © 2020 medica. All rights reserved.
//

import UIKit
import EW202W

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
        
        SLPLTcpManager.sharedLTCP()?.installSDK(withToken: self.tokenTextfield.text, ip: self.urlTextfield.text, channelID: NSInteger(self.channelidTextfield.text!) ?? 0 , timeout: 10.0, completion: { (status: SLPDataTransferStatus, data: Any?) in
            if status == SLPDataTransferStatus.succeed
            {
                SLPLTcpManager.sharedLTCP()?.loginDeviceID(self.deviceIdTextfield.text, completion: { (status: SLPDataTransferStatus, data: Any?) in
                    if status == SLPDataTransferStatus.succeed
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
        
        SLPLTcpManager.sharedLTCP()?.publicUpdateOperation(withDeviceID: self.deviceIdTextfield.text, deviceType: SLPDeviceTypes.EW202W, firmwareType: 1, firmwareVersion: self.versionTextfield.text, timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?) in
            
            if status == SLPDataTransferStatus.succeed
            {
                NotificationCenter.default.addObserver(self, selector: #selector(self.receive_notifaction(notify:)), name: Notification.Name(kNotificationNameUpdateRateChanged), object: nil)
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
        
        SLPLTcpManager.sharedLTCP()?.bindDevice(self.deviceIdTextfield.text, leftRight: 0, timeout: 10.0, completion: { (status: SLPDataTransferStatus, data: Any?) in
            
            if status == SLPDataTransferStatus.succeed
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
        
        SLPLTcpManager.sharedLTCP()?.unBindDevice(self.deviceIdTextfield.text, leftRight: 0, timeout: 10.0, completion: { (status: SLPDataTransferStatus, data: Any?)  in
            if status == SLPDataTransferStatus.succeed
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
