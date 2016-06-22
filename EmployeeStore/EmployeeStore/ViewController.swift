//
//  ViewController.swift
//  EmployeeStore
//
//  Created by Kony on 22/06/16.
//  Copyright (c) 2016 Kony. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Contact: UITextField!
    
    @IBOutlet weak var Project: UITextField!
    
    @IBOutlet weak var Image: UIImageView!
    
    var employee: Employees?
    let picker = UIImagePickerController()
    
    let mContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBAction func Browsegallery(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
       let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        Image.contentMode = .ScaleAspectFit
        Image.image = image
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func Save(sender: UIButton) {
       
        if employee == nil {
        let employeedescription = NSEntityDescription.entityForName("Employees", inManagedObjectContext: mContext!)
        
         employee = Employees(entity : employeedescription! , insertIntoManagedObjectContext: mContext);
        }
        employee?.name = Name.text
        employee?.contact = Contact.text
        employee?.project = Project.text
        
        let image = Image.image
        let imagedata = UIImageJPEGRepresentation(image, 1.0)
        employee?.image = imagedata
        
        var error: NSError?
        mContext?.save(&error)
        
        if let err = error{
            let a = UIAlertView(title: "Failed", message: err.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
            a.show()
        }
        else {
            
            let b = UIAlertView(title: "Success", message: "Record inserted", delegate: nil, cancelButtonTitle: "OK")
            b.show()
            
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        if let s = employee{
            Name.text = employee?.name
            Contact.text = employee?.contact
            Project.text = employee?.project
            
            Image.image = UIImage(data: employee!.image)
            Image.contentMode = .ScaleAspectFit
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

