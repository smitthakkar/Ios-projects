//
//  ViewController.swift
//  Photos
//
//  Created by Kony on 16/06/16.
//  Copyright (c) 2016 Kony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var ImageName: UILabel!
    
    @IBAction func Previous(sender: UIButton) {
        index--;
        var final = index % objects.count
        var string: String = objects[final] as! String
        myImageView.image = UIImage(named: filepath!.stringByAppendingPathComponent(string));
        ImageName.text = objects[final] as? String
    }
    
    @IBAction func Next(sender: UIButton) {
        index++;
        var final = index % objects.count
        var string: String = objects[final] as! String
        myImageView.image = UIImage(named: filepath!.stringByAppendingPathComponent(string));
        ImageName.text = objects[final] as? String

    }
    
    
    let picker = UIImagePickerController()
    var filepath : String? ;
    var count = 0;
    var objects = [(AnyObject)]()
    var index: Int = 1000;
    
    @IBAction func shootPhoto(sender: UIButton) {
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        picker.modalPresentationStyle = .FullScreen
        presentViewController(picker, animated: true, completion: nil)
        }
        else {
            noCamera()
        }
        
    }
    
    @IBAction func Save(sender: UIButton) {
        
        count++;
        
        var newfile = filepath?.stringByAppendingPathComponent("\(count).png")
        var myimage = myImageView.image
        ImageName.text = "\(count).png"
        saveImage(myimage!, path: newfile!)
        
    }
    @IBAction func photoFromLibrary(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     picker.delegate = self
        var error: NSError?
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        let tempVideoPath = documentsDirectory.stringByAppendingPathComponent("Photos")
        filepath = tempVideoPath;
        
        if (!NSFileManager.defaultManager().fileExistsAtPath(tempVideoPath)) {
            
            NSFileManager.defaultManager() .createDirectoryAtPath(tempVideoPath, withIntermediateDirectories: false, attributes: nil, error: &error)
            println("Success")
        }
        Loadimage()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .ScaleAspectFit
        myImageView.image = image
       
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func noCamera(){
        let alertVC = UIAlertController(title : "No camera", message : "This device has no camera", preferredStyle : .Alert)
        let okAction = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
        
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        
        var error1: NSErrorPointer = nil
        //println("Reached")
        println(path)
    
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        pngImageData.writeToFile(path, options: NSDataWritingOptions.DataWritingAtomic, error: error1)
        println(error1.debugDescription)
        Loadimage()
        return result
        
    }
    
    func Loadimage(){
        let documentsUrl: NSURL =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as! NSURL
        var error1: NSErrorPointer = nil
        var i:Int
        objects.removeAll(keepCapacity: false)
       
        let fm = NSFileManager.defaultManager()
        //var path = NSBundle.mainBundle().resourcePath!
        println(filepath)
        //path = path.stringByAppendingPathComponent("/Photos")
        let items = fm.contentsOfDirectoryAtPath(filepath!, error: error1)
        if items != nil{
        for item in items! {
             
                objects.append(item)
            
            }
        }
        else{
            println(error1.debugDescription)
        }
        println("Reached")
        for i=0; i < objects.count; i++ {
            println(objects[i])
            
        }
        index = objects.count
        
        
    }
    

}

