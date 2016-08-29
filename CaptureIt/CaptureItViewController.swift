//
//  CaptureItViewController.swift
//  CaptureIt
//
//  Created by Tushar Sharma on 29/08/16.
//  Copyright © 2016 Edbinx. All rights reserved.
//

import UIKit
import AVFoundation

final internal class CaptureItViewController: UIViewController {

    private let captureSession = AVCaptureSession()
    private var captureDevice:AVCaptureDevice?
    private var previewLayer:AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AVCSessionProperties()
        print("DEVICES", AVCaptureDevice.devices())
        // Do any additional setup after loading the view.
    }
    
    private func AVCSessionProperties() {
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        print(captureDevice)
        
        if captureDevice != nil {
            print("HERE")
            beginSession()
        }
    }
    
    private func beginSession() {
        do {
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
        } catch let error {
            print(error)
        }
        let width = UIScreen.mainScreen().bounds.size.width
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/1.5)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureSession.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
