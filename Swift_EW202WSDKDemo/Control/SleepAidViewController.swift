//
//  SleepAidViewController.swift
//  BLENOX2Demo-Swift
//
//  Created by San on 12/9/2019.
//  Copyright © 2019 medica. All rights reserved.
//

import UIKit

class SleepAidViewController: UIViewController {
    
    @IBOutlet weak var sendBT1: UIButton!
    @IBOutlet weak var playdBT: UIButton!
    @IBOutlet weak var sendBT2: UIButton!
    @IBOutlet weak var closeBT: UIButton!
    @IBOutlet weak var saveBT: UIButton!
    
    @IBOutlet weak var musicIDTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var rTextField: UITextField!
    @IBOutlet weak var gTextField: UITextField!
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var wTextField: UITextField!
    @IBOutlet weak var brightnessTextField: UITextField!
    @IBOutlet weak var minTextField: UITextField!
    
    @IBOutlet weak var cview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUI();
        self.initData()
    }
    
    func setUI() -> Void {
        self.sendBT1.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.sendBT1.layer.cornerRadius = 2.0;
        self.sendBT1.layer.masksToBounds = true;
        self.sendBT2.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.sendBT2.layer.cornerRadius = 2.0;
        self.sendBT2.layer.masksToBounds = true;
        self.playdBT.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0);
        self.playdBT.layer.cornerRadius = 2.0;
        self.playdBT.layer.masksToBounds = true;
        self.saveBT.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.saveBT.layer.cornerRadius = 2.0;
        self.saveBT.layer.masksToBounds = true;
        self.closeBT.backgroundColor = UIColor.init(red: 42/255.0, green: 151/255.0, blue: 254/255.0, alpha: 1.0)
        self.closeBT.layer.cornerRadius = 2.0;
        self.closeBT.layer.masksToBounds = true;
        
        self.playdBT.setTitle("播放", for: UIControl.State.normal)
        self.playdBT.setTitle("暂停", for: UIControl.State.selected)
    }
    
    func initData() -> Void {
        
        //        default value
        /*音乐编号
         *31086，31087，31088，31089，31090，31091，31092，31093，31094，31095，31096，31097
         */
        self.musicIDTextField.text = "31086"
        self.volumeTextField.text = "10"
        
        self.rTextField.text = "50"
        self.gTextField.text = "50"
        self.bTextField.text = "50"
        self.wTextField.text = "50"
        
        self.brightnessTextField.text = "50"
        self.minTextField.text = "5"
    }
    
    
    
    @IBAction func changeVolume(_ sender: Any) {
        
        let aidInfo : SLPAidInfo = SLPAidInfo()
        let vol  = UInt8(self.volumeTextField.text!)!
        aidInfo.volume = vol
        
        SLPLTcpManager.sharedLTCP()?.ew202wConfigAidInfo(aidInfo, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
            
            if status == SLPDataTransferStatus.succeed
            {
                print("change volume succeed !")
            }
            else
            {
                print("change volume failed !")
            }
        })
    }
    
    @IBAction func play(_ sender: Any) {
        
        ((sender) as! UIButton).isSelected = !(sender as! UIButton).isSelected
        
        let musicID = UInt16(self.musicIDTextField.text!)!
        let vol  = UInt8(self.volumeTextField.text!)!
        let aidInfo : SLPAidInfo = SLPAidInfo()
        aidInfo.volume = vol
        aidInfo.musicID  = musicID
        
        if (sender as! UIButton).isSelected {
            aidInfo.musicFlag = 0
            
            SLPLTcpManager.sharedLTCP()?.ew202wConfigAidInfo(aidInfo, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
                
                if status == SLPDataTransferStatus.succeed
                {
                    print("turn on aid music succeed !")
                }
                else
                {
                    print("turn on aid music  failed !")
                }
                
            })
        }
        else
        {
            aidInfo.musicFlag = 1
            
            SLPLTcpManager.sharedLTCP()?.ew202wConfigAidInfo(aidInfo, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
                
                if status == SLPDataTransferStatus.succeed
                {
                    print("turn off aid music succeed !")
                }
                else
                {
                    print("turn off aid music  failed !")
                }
                
            })
        }
    }
    
    @IBAction func changeColor(_ sender: Any) {
        let r  = UInt8(self.rTextField.text!)
        let g  = UInt8(self.gTextField.text!)
        let b  = UInt8(self.bTextField.text!)
        let w  = UInt8(self.wTextField.text!)
        let br = UInt8(self.brightnessTextField.text!)
        
        let aidInfo : SLPAidInfo = SLPAidInfo()
        aidInfo.lightFlag = 1;
        aidInfo.r = r!;
        aidInfo.g = g!;
        aidInfo.b = b!;
        aidInfo.w = w!;
        aidInfo.brightness = br!
        
        SLPLTcpManager.sharedLTCP()?.ew202wConfigAidInfo(aidInfo, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
            
            if status == SLPDataTransferStatus.succeed
            {
                print("change aid sleep color succeed !")
            }
            else
            {
                print("change aid sleep color failed !")
            }
            
        })
    }
    
    @IBAction func closeLight(_ sender: Any) {
        
        let aidInfo : SLPAidInfo = SLPAidInfo()
        aidInfo.lightFlag = 0;
        
        SLPLTcpManager.sharedLTCP()?.ew202wConfigAidInfo(aidInfo, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
            
            if status == SLPDataTransferStatus.succeed
            {
                print("turn off light succeed !")
            }
            else
            {
                print("turn off light failed !")
            }
            
        })
    }
    
    @IBAction func save(_ sender: Any) {
        
        let r  = UInt8(self.rTextField.text!)!
        let g  = UInt8(self.gTextField.text!)!
        let b  = UInt8(self.bTextField.text!)!
        let w  = UInt8(self.wTextField.text!)!
        let br = UInt8(self.brightnessTextField.text!)!
        let aidStopDuration = UInt16(self.minTextField.text!)!
        let vol  = UInt8(self.volumeTextField.text!)!
        
        
        let aidInfo : SLPAidInfo = SLPAidInfo()
        aidInfo.musicFlag = UInt8(self.playdBT.isSelected ? 1 : 0)
        aidInfo.musicID =  UInt16(self.musicIDTextField.text!)!
        aidInfo.volume = vol
        aidInfo.r = r
        aidInfo.g = g
        aidInfo.b = b
        aidInfo.w = w
        aidInfo.brightness = br
        aidInfo.aidStopDuration = aidStopDuration
        
        SLPLTcpManager.sharedLTCP()?.ew202wConfigAidInfo(aidInfo, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: { (status: SLPDataTransferStatus, data: Any?)in
            
            if status == SLPDataTransferStatus.succeed
            {
                print("config aid sleep succeed !")
            }
            else
            {
                print("config aid sleep failed !")
            }
            
        })
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
