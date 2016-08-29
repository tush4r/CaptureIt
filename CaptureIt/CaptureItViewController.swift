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
    var output = AVCaptureStillImageOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet private weak var takePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AVCSessionProperties()
        // Do any additional setup after loading the view.
    }
    
    private func AVCSessionProperties() {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        output.outputSettings = [ AVVideoCodecKey: AVVideoCodecJPEG ]
        captureSession.addOutput(output)
        
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
            errorOccured()
        }
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
    
    @IBAction func takePhoto(sender: AnyObject) {
        guard let connection = output.connectionWithMediaType(AVMediaTypeVideo) else { return }
        connection.videoOrientation = .Portrait
        
        output.captureStillImageAsynchronouslyFromConnection(connection) { (sampleBuffer, error) in
            guard sampleBuffer != nil && error == nil else { self.errorOccured(); return }
            
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
            guard let image = UIImage(data: imageData) else {
                self.errorOccured()
                return
            }
            print(image)
             self.performSegueWithIdentifier("image", sender: nil)
        }
        
    }

    private func errorOccured() {
        let errorView = UIAlertController(title: "Error", message: "An Error Occured", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        errorView.addAction(defaultAction)
        self.presentViewController(errorView, animated: true, completion: nil)
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
