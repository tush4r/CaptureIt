//
//  CaptureImageViewController.swift
//  CaptureIt
//
//  Created by Tushar Sharma on 29/08/16.
//  Copyright © 2016 Edbinx. All rights reserved.
//

import UIKit

class CaptureImageViewController: UIViewController {
    
    private let photoView = UIImageView()
    var imageData = UIImage()
    

    @IBOutlet weak var capturedImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageData)
        capturedImage.contentMode = .ScaleAspectFit
        capturedImage.image = imageData
        //setImageView()
        // Do any additional setup after loading the view.
    }
    
    private func setImageView() {
        photoView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/1.5)
        photoView.contentMode = .ScaleAspectFill
        photoView.backgroundColor = .grayColor()
        self.view.addSubview(photoView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
