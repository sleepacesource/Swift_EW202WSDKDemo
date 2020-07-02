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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUI();
        
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
        
        SLPLTcpManager.sharedInstance()?.ew202wLightControlOperation(1, brightness: br, lightMode: 0xff, light: light, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: {(status: SLPDataTransferStatus, data: Any?) in
            
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
        
        SLPLTcpManager.sharedInstance()?.ew202wLightControlOperation(2, brightness: br, lightMode: 0xff, light: light, deviceInfo: "EW22W20C00044", timeout: 10.0, callback: {(status: SLPDataTransferStatus, data: Any?) in
            
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
        
        SLPLTcpManager.sharedInstance()?.ew202wLightControlOperation(0, brightness: 0, lightMode: 0xff, light:  SLPLight(), deviceInfo: "EW22W20C00044", timeout: 10.0, callback: {(status: SLPDataTransferStatus, data: Any?) in
            
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
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.endEditing(true)
    }
    
}
