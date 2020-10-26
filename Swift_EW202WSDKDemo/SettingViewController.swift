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
    
    @IBOutlet weak var timeFormat: UITextField!
    @IBOutlet weak var saveTimeFormat: UIButton!

    @IBOutlet weak var syncServerTimeSwitch: UISwitch!

    @IBOutlet weak var clockSwitch: UISwitch!
    @IBOutlet weak var clockStartMinTextField: UITextField!
    @IBOutlet weak var clockStartHourTextField: UITextField!
    @IBOutlet weak var clockEndMinTextField: UITextField!
    @IBOutlet weak var clockEndHourTextField: UITextField!
    @IBOutlet weak var saveClock: UIButton!

    
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
            SLPLTcpManager.sharedInstance()?.ew202wAlarmRreviewOperationVolume(vol, brightness: 100, operation: 1, musicID: musicID, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
                
                
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
            
            SLPLTcpManager.sharedInstance()?.ew202wAlarmRreviewOperationVolume(vol, brightness: 100, operation: 0, musicID: musicID, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
                
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
    
    @IBAction func saveTime(_ sender: Any) {
        let time  = UInt8(self.timeFormat.text!)!

        SLPLTcpManager.sharedInstance()?.ew202wConfigSystem(0, value: time == 12 ? 0 : 1, pincode: "", deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?) in
            if status == SLPDataTransferStatus.succeed
            {
                print("save time format succeed !")
            }
            else
            {
                print("save time format failed !")
            }
        })
    }
    
    @IBAction func syncServerTimeSwitchAction(_ sender: Any) {
        let isOpen = self.syncServerTimeSwitch.isOn ? 1 : 0
        
        SLPLTcpManager.sharedInstance()?.ew202wConfigSystem(1, value: UInt8(isOpen), pincode: "", deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?) in
            if status == SLPDataTransferStatus.succeed
            {
                print("save sync server time succeed !")
            }
            else
            {
                print("save sync server time failed !")
            }
        })
    }
    
    @IBAction func saveClock(_ sender: Any) {
        ///时钟休眠结构
        let clock :SLPClockDormancyBean = SLPClockDormancyBean()
        
        clock.flag = self.clockSwitch.isOn ? 1 : 0
        clock.startHour = UInt8(self.clockStartHourTextField.text!)!
        clock.startMin = UInt8(self.clockStartMinTextField.text!)!
        clock.endHour = UInt8(self.clockEndHourTextField.text!)!
        clock.endMin = UInt8(self.clockEndMinTextField.text!)!

        let dic = ["sleepFlag":(self.clockSwitch.isOn ? "1" : "0"),"startHour" : self.clockStartHourTextField.text!,"startMin" : self.clockEndHourTextField.text!,"endHour" : self.clockEndHourTextField.text!,"endMin" : self.clockEndMinTextField.text!]
        
        SLPHTTPManager.sharedInstance().configClockDormancy(withParameters: dic, deviceInfo: "EW22W20C00044", timeOut: 10.0, completion: { (status: Bool, data: Any?, error: String) in
            if status == true
            {
                print("save clock succeed !")
            }
            else
            {
                print("save clock failed !")
            }
        })
    }
    
    @IBAction func saveAlarmAction(_ sender: Any) {
        
        ///闹钟结构
        let dic = ["num":"1","alarmId" : "0","alarmFlag" : self.alrmRepeatTextField.text!,"smartFlag" : "0","smartOffset" : "0","hour" : self.alarmHourTextField.text!,"min" : self.alarmMinTextField.text!,"week" : self.alrmRepeatTextField.text!,"lazyTimes" : (self.snoozeSwitch.isOn ? "3" : "0"),"lazyTime" : "9","volum" : self.volumeTextField.text!,"lightStrength" : "100","musicId" : self.musicIDTextField.text!,"timeStamp" : String(NSDate().timeIntervalSince1970),"useFlag" : "1"]
        
        SLPHTTPManager.sharedInstance().alarmConfig(withParameters: dic, deviceInfo: "EW22W20C00044", deviceType: SLPDeviceTypes.EW202W, timeOut: 10.0, completion: { (status: Bool, data: Any?, error: String) in
            if status == true
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
