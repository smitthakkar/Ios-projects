//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Kony on 24/06/16.
//  Copyright (c) 2016 Kony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var LattitudeU: UITextField!
    
    @IBOutlet weak var LongitudeU: UITextField!
    
    @IBOutlet weak var Place: UILabel!
    
   
    @IBOutlet weak var Weatherrepo: UILabel!
    
    @IBOutlet weak var ActualLat: UILabel!
    
    
    @IBOutlet weak var ActualLon: UILabel!
   
    @IBAction func Information(sender: UIButton) {
        //ActualLon.text = "hello";
        //ActualLat.text = "world"
        getlat(LattitudeU.text!, lon: LongitudeU.text!);
    }
    
    
    var finalJSON : NSString? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func getlat(lat: String, lon: String){
        if(lat.isEmpty || lon.isEmpty){
            let alert = UIAlertController(title:"Alert!" ,message: "Enter Longitude and Latitude values",preferredStyle: UIAlertControllerStyle.Alert);
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            alert.addAction(cancelAction);
            self.presentViewController(alert, animated: true, completion: nil);
        }
        else{
           
            let weather = WeatherForecast()
            finalJSON =   weather.getWeather(lat, lon: lon);
            print("Final Json Content :\(finalJSON)")
            if finalJSON != "NO123"{
               let data: NSData = finalJSON!.dataUsingEncoding(NSUTF8StringEncoding)!
              
               var json: Dictionary<String,AnyObject>?;
              do{
                json = try NSJSONSerialization.JSONObjectWithData(data, options:.AllowFragments) as? Dictionary
                print(" Success :\(json)")
                let cordd = json!["coord"]
                if cordd == nil{
                    let alert = UIAlertController(title:"Alert!" ,message: "Could not fetch,try something else",preferredStyle: UIAlertControllerStyle.Alert);
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    alert.addAction(cancelAction);
                    self.presentViewController(alert, animated: true, completion: nil);
                }
                else{
                    let coord = json!["coord"];
               
                    if var tempFloat:Float! = coord!["lat"] as? Float{
                      print("\(tempFloat)")
                       ActualLat.text = "\(tempFloat!)";
                     }
                    if var tempFloat2:Float! = coord!["lon"] as? Float{
                       ActualLon.text = "\(tempFloat2!)";
                    }
                    var Climate: String?;
                    let name = json!["name"]
                    if name != nil{
                       Climate = "\(name!)";
                    }
                   else {
                      Climate = "" ;
                    }
                    Place.text = Climate;
                    let stats1 = json!["weather"] as! Array<AnyObject>;
                    for item in stats1{
                       let w = item["description"];
                       Climate = "\(w!!)"
                     }
                    Weatherrepo.text = Climate
                     }
              }
             catch{
                print(error)
                let alert = UIAlertController(title:"Alert!" ,message: "\(error)",preferredStyle: UIAlertControllerStyle.Alert);
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                alert.addAction(cancelAction);                self.presentViewController(alert, animated: true, completion: nil);
                  }
                
           }
            else{
                let alert = UIAlertController(title:"Alert!" ,message: "Could not retrieve Json",preferredStyle: UIAlertControllerStyle.Alert);
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                alert.addAction(cancelAction);                self.presentViewController(alert, animated: true, completion: nil);
          }
        }
      }
    
}

