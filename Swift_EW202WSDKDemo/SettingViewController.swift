//
//  SettingViewController.swift
//  BLENOX2Demo-Swift
//
//  Created by San on 12/9/2019.
//  Copyright © 2019 medica. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var alarmMinTextField: UITextField!
    @IBOutlet weak var alarmHourTextField: UITextField!
    @IBOutlet weak var alrmRepeatTextField: UITextField!
    @IBOutlet weak var musicIDTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var snoozeTextField: UITextField!
    @IBOutlet weak var previewAlarm: UIButton!
    @IBOutlet weak var saveAlarm: UIButton!
    
    @IBOutlet weak var alarmLightSwitch: UISwitch!
    @IBOutlet weak var snoozeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUI()
        self.initData()
    }
    
    func setUI() -> Void {
        self.previewAlarm.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.previewAlarm.layer.cornerRadius = 2.0;
        self.previewAlarm.layer.masksToBounds = true;
        self.saveAlarm.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.saveAlarm.layer.cornerRadius = 2.0;
        self.saveAlarm.layer.masksToBounds = true;
        self.previewAlarm.setTitle("预览闹钟", for: UIControl.State.normal)
        self.previewAlarm.setTitle("停止预览", for: UIControl.State.selected)
    }
    
    func initData() -> Void {
        
        //a闹钟
        /*闹钟音乐编号
         *31098，31099，31100，31101，31102，31103
         */
        self.musicIDTextField.text = "31098"
        self.alarmHourTextField.text = "5"
        self.alarmMinTextField.text = "5"
        self.alrmRepeatTextField.text = "0"
        self.volumeTextField.text = "100"
        self.alarmLightSwitch.isSelected = true
        
    }
    
    
    @IBAction func previewAlarmAction(_ sender: Any) {
        
        ((sender) as! UIButton).isSelected = !(sender as! UIButton).isSelected
        
        let musicID = UInt16(self.musicIDTextField.text!)!
        let vol  = UInt8(self.volumeTextField.text!)!
        
        if (sender as! UIButton).isSelected
        {
            SLPLTcpManager.sharedLTCP()?.ew202wAlarmRreviewOperationVolume(vol, brightness: 100, operation: 1, musicID: musicID, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
                
                
                if status == SLPDataTransferStatus.succeed
                {
                    print("start preview succeed !")
                }
                else
                {
                    print("start preview failed !")
                }
            })
        }
        else
        {
            
            SLPLTcpManager.sharedLTCP()?.ew202wAlarmRreviewOperationVolume(vol, brightness: 100, operation: 0, musicID: musicID, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
                
                if status == SLPDataTransferStatus.succeed
                {
                    print("stop preview succeed !")
                }
                else
                {
                    print("stop preview failed !")
                }
            })
            
        }
    }
    
    @IBAction func saveAlarmAction(_ sender: Any) {
        
        ///闹钟结构
        let alarmInfo:SLPAlarmInfo = SLPAlarmInfo()
        alarmInfo.alarmID = 0///闹钟编号
        alarmInfo.isOpen = self.alarmLightSwitch.isOn
        alarmInfo.hour = UInt8(self.alarmHourTextField.text!)!
        alarmInfo.minute = UInt8(self.alarmMinTextField.text!)!
        alarmInfo.flag = UInt8(self.alrmRepeatTextField.text!)!
        alarmInfo.snoozeTime = self.snoozeSwitch.isOn ? 3 : 0;
        alarmInfo.snoozeLength = 9
        alarmInfo.volume = UInt8(self.volumeTextField.text!)!
        alarmInfo.brightness =  100
        alarmInfo.musicID = UInt16(self.musicIDTextField.text!)!
        alarmInfo.timestamp = UInt32(NSDate().timeIntervalSince1970)
        alarmInfo.enable = 1
        
        SLPLTcpManager.sharedLTCP()?.alarmConfig(alarmInfo, deviceInfo: "EW22W20C00044", deviceType: SLPDeviceTypes.EW202W, timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?) in
            if status == SLPDataTransferStatus.succeed
            {
                print("save alarm succeed !")
            }
            else
            {
                print("save alarm failed !")
            }
        })
        
    }
    
}
