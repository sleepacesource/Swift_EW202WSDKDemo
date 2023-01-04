//
//  LightViewController.swift
//  BLENOX2Demo-Swift
//
//  Created by San on 12/9/2019.
//  Copyright © 2019 medica. All rights reserved.
//

import UIKit
class LightViewController: UIViewController {
    
    @IBOutlet weak var rText: UITextField!
    @IBOutlet weak var gText: UITextField!
    @IBOutlet weak var bText: UITextField!
    @IBOutlet weak var wText: UITextField!
    @IBOutlet weak var brightnessText: UITextField!
    
    @IBOutlet weak var sendBT1: UIButton!
    @IBOutlet weak var sendBT2: UIButton!
    @IBOutlet weak var closeBT: UIButton!
    @IBOutlet weak var checkWiFi: UIButton!
    @IBOutlet weak var wifiLabel: UILabel!
    
    let deviceId =   UserDefaults.standard.string(forKey: "deviceID") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUI();
        self.receiceData()
    }
    
    func setUI() -> Void {
        
        self.sendBT1.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.sendBT1.layer.cornerRadius = 2.0;
        self.sendBT1.layer.masksToBounds = true;
        
        self.sendBT2.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.sendBT2.layer.cornerRadius = 2.0;
        self.sendBT2.layer.masksToBounds = true;
        
        self.closeBT.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.closeBT.layer.cornerRadius = 2.0;
        self.closeBT.layer.masksToBounds = true;
        
        ///default value(example)
        self.rText.text = "50"
        self.gText.text = "50"
        self.bText.text = "50"
        self.wText.text = "1"
        self.brightnessText.text = "50"
        
        self.checkWiFi.setTitle(NSLocalizedString("checkWifi", comment: ""), for: UIControl.State.normal)
        self.wifiLabel.text = NSLocalizedString("none", comment: "")
    }
    
    func receiceData() -> Void {
        //post realtime data
        NotificationCenter.default.addObserver(self, selector: #selector(receive_wifiSignalChanged(notify:)), name: Notification.Name(kNotificationNameRequestDeviceWiFiSignalChanged), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(receive_online(notify:)), name: Notification.Name(kNotificationNameRequestDeviceOnlineStatusChanged), object: nil)
        
    }
    
    @objc func receive_wifiSignalChanged(notify: NSNotification) -> Void {
        
        print("wifi signal--->",notify)
        
        let wifi: SLPTCPWiFiInfo = notify.userInfo?[kNotificationPostData] as! SLPTCPWiFiInfo
        self.wifiLabel.text = String(wifi.signalStrength)
    }
    
    @objc func receive_online(notify: NSNotification) -> Void {
        let deviceOnline: SLPTCPOnlineStatus = notify.userInfo?[kNotificationPostData] as! SLPTCPOnlineStatus
        print("deviceid and online status --->",deviceOnline.deviceID,deviceOnline.isOnline)
    }
    
    
    @IBAction func changeColor(_ sender: Any) {
        let r  = UInt8(self.rText.text!)
        let g  = UInt8(self.gText.text!)
        let b  = UInt8(self.bText.text!)
        let w  = UInt8(self.wText.text!)
        let br = UInt8(self.brightnessText.text!)!
        
        let light: SLPLight = SLPLight()
        light.r = r ?? 0
        light.g = g ?? 0
        light.b = b ?? 0
        light.w = w ?? 0
        
        SLPLTcpManager.sharedInstance()?.ew202wLightControlOperation(1, brightness: br, lightMode: 0xff, light: light, deviceInfo: deviceId, timeout: 10.0, callback: {(status: SLPDataTransferStatus, data: Any?) in
            
            if status == SLPDataTransferStatus.succeed
            {
                print("change color succeed !")
            }
            else
            {
                print("change color failed !")
            }
            
        })
    }
    
    @IBAction func changeBrightness(_ sender: Any) {
        
        let r  = UInt8(self.rText.text!)
        let g  = UInt8(self.gText.text!)
        let b  = UInt8(self.gText.text!)
        let w  = UInt8(self.wText.text!)
        let br = UInt8(self.brightnessText.text!)!
        
        let light: SLPLight = SLPLight()
        light.r = r ?? 0
        light.g = g ?? 0
        light.b = b ?? 0
        light.w = w ?? 0
        
        SLPLTcpManager.sharedInstance()?.ew202wLightControlOperation(2, brightness: br, lightMode: 0xff, light: light, deviceInfo: deviceId, timeout: 10.0, callback: {(status: SLPDataTransferStatus, data: Any?) in
            
            if status == SLPDataTransferStatus.succeed
            {
                print("change brightness succeed !")
            }
            else
            {
                print("change brightness failed !")
            }
            
        })
    }
    
    
    @IBAction func closeLight(_ sender: Any) {
        SLPLTcpManager.sharedInstance()?.ew202wLightControlOperation(0, brightness: 0, lightMode: 0xff, light:  SLPLight(), deviceInfo: deviceId, timeout: 10.0, callback: {(status: SLPDataTransferStatus, data: Any?) in

            if status == SLPDataTransferStatus.succeed
            {
                print("close succeed !")
            }
            else
            {
                print("close failed !")
            }
        })
    }
    
    @IBAction func checkWiFiSignal() {
         let deviceId =   UserDefaults.standard.string(forKey: "deviceID") ?? ""
        
         SLPLTcpManager.sharedInstance()?.publicGetWiFiSignal(withDeviceID: deviceId, deviceType: SLPDeviceTypes.EW202W, timeout: 10.0, callback: {
             (status: SLPDataTransferStatus, data: Any?)in
             if status == SLPDataTransferStatus.succeed
             {
                 let wifi : SLPTCPWiFiInfo = data as! SLPTCPWiFiInfo
               
                 self.wifiLabel.text = String(wifi.signalStrength)
             }
         })
     }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.endEditing(true)
    }
    
}
