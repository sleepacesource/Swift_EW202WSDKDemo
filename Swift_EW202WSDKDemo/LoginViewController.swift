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
        
        self.urlTextfield.text = "http://120.24.68.136:8091";
        self.channelidTextfield.text = "54500"
        self.tokenTextfield.text = "kxu5jh5xmfap"
        self.deviceIdTextfield.text = "akclsxdsyi8m9";//EW22W20C00890
        
        
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
        
        var connectStr = ""
        SLPHTTPManager.sharedInstance().authorize(self.tokenTextfield.text!, timeout: 0, completion: { (status: Bool, json: Any?, error: String) in
            if status == true
            {
                let dic = json as? [String: Any?];
                                
                let data = dic?["data"] as? [String: Any?];
                
                let tcpServer = data?["tcpServer"] as? [String : String];
                let sid = data?["sid"] as! String;
                let ip = tcpServer?["ip"];
                let port = Int((tcpServer?["port"]!)!);
                
                
                SLPLTcpManager.sharedInstance()?.loginHost(ip, port: port!, token: sid, completion: { (succeed: Bool) in
                    if succeed
                    {
                        connectStr = NSLocalizedString("connection_succeeded", comment: "")
                    }
                    else
                    {
                        connectStr = NSLocalizedString("Connection_failed", comment: "")
                    }
                    self.alertShow(message: connectStr as NSString)
                })
            }
            else
            {
                print("authorize failed")
                self.alertShow(message: NSLocalizedString("authorize_failed", comment: "") as NSString)
            }
        })
    }
    
    @IBAction func upgrade(_ sender: Any) {
        SLPLTcpManager.sharedInstance()?.publicUpdateOperation(withDeviceID: self.deviceIdTextfield.text!, deviceType: SLPDeviceTypes.EW202W, firmwareType: 1, firmwareVersion: self.versionTextfield.text!, timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?) in
            
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
        
        SLPHTTPManager.sharedInstance().bindDevice(withDeviceId: self.deviceIdTextfield.text!, timeOut: 10.0, completion: { (result: Bool, data: Any?,  error: String) in
            var bindStr = ""
            if result
            {
                print("bind succeed")
                bindStr = NSLocalizedString("bind_account_success", comment: "")
                UserDefaults.standard.set(self.deviceIdTextfield.text!, forKey: "deviceID")
            }
            else
            {
                print("bind failed")
                bindStr = NSLocalizedString("bind_fail", comment: "")
            }
            self.alertShow(message: bindStr as NSString)
            
        })
    }
    

    @IBAction func unbind(_ sneder:Any){

        SLPHTTPManager.sharedInstance().unBindDevice(withDeviceId: self.deviceIdTextfield.text!, timeOut: 10.0, completion: { (result: Bool,  error: String) in
            var unbindStr = ""
            if result
            {
                print("unbind succeed")
                unbindStr = NSLocalizedString("unbind_success", comment: "")
            }
            else
            {
                print("unbind failed")
                unbindStr = NSLocalizedString("unbind_failed", comment: "")
            }
            
            self.alertShow(message: unbindStr as NSString)
        })
        
        
    }
    
    func alertShow(message: NSString ) -> Void {
        let alert = UIAlertController.init(title: "", message: message as String, preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
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
