//
//  LoginViewController.swift
//  Swift_TWPSDKDemo
//
//  Created by San on 12/6/2020.
//  Copyright © 2020 medica. All rights reserved.
//

import UIKit
import SLPTCP

class LoginViewController: UIViewController {
    
    @IBOutlet weak var urlTextfield: UITextField!
    @IBOutlet weak var channelidTextfield: UITextField!
    @IBOutlet weak var connectBT: UIButton!
    @IBOutlet weak var deviceIdTextfield: UITextField!
    @IBOutlet weak var versionTextfield: UITextField!
    @IBOutlet weak var upgradeBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
        
        self.urlTextfield.text = "http://172.14.0.111:8082"
        self.channelidTextfield.text = "13700"
    }
    
    func initUI() -> Void {
        self.connectBT.layer.cornerRadius = 2.0;
        self.connectBT.layer.masksToBounds = true;
        self.upgradeBT.layer.cornerRadius = 2.0;
        self.upgradeBT.layer.masksToBounds = true;
    }
    
    @IBAction func connect(_ sender: Any) {
        let dic = ["url":"http://172.14.0.111:8082","channelID" : "13700"]
        SLPHTTPManager.sharedInstance().initHttpServiceInfo(dic);

        //http authorize
        SLPHTTPManager.sharedInstance().authorize("r8xfa7hdjcm6", timeout: 10) { (result: Bool, responseObject: Any, error: String?) in
             print("authorize result-->",result,responseObject)
//              tcpDic = responseObject[@"data"][@"tcpServer"];
//              userDic = responseObject[@"data"][@"user"];
            
            if result {
                //login device
                SLPLTcpManager.sharedInstance()?.loginHost("ccc.sleepace.com", port: 9010, deviceID:"jfbkwowszdm6d", token: "sleepace_diXWK4YzweephfNAyGGx", completion: { (succeed: Bool) in
        
                    print("login tcp result ---",succeed)
                    
                })
            }
            else{
                  print("authorize failed")
            }
        }
        
        
    }
    
    @IBAction func upgrade(_ sender: Any) {
        
//        SLPLTcpManager.sharedInstance()?.lTcp.publicUpdateOperation(withDeviceID: "y24mlthq3fxga", deviceType: SLPDeviceTypes.TWP2, firmwareType: 2, firmwareVersion: 160, timeout: 10.0, completion: { (status: SLPDataTransferReturnStatus, data: Any?)in
//            
//        })
        
        
        
        
    }
    
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignTextfiled()
    }
  
    func resignTextfiled() -> Void {
     
        self.urlTextfield.resignFirstResponder()
        self.channelidTextfield.resignFirstResponder()
        self.deviceIdTextfield.resignFirstResponder()
        self.versionTextfield.resignFirstResponder()
    }
}
