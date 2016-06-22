//
//  ViewController.swift
//  Scroller
//
//  Created by Kony on 10/06/16.
//  Copyright (c) 2016 Kony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RandomLabel: UILabel!
    
    @IBOutlet weak var RoundLabel: UILabel!
    
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    var fscore = 0;
    var rounds = 1;
    var randomnum = 22;
    var sliderval = 50;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RoundLabel.text = rounds.description;
        ScoreLabel.text = fscore.description;
        randomnum = 1 + Int(arc4random_uniform(100))
        RandomLabel.text = randomnum.description;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Info(sender: UIButton) {
        
        var score = 0;
        var fmessage = "Something";var title1 = "Something ";
       
        if randomnum == sliderval{
            score = 100
            fscore += score;
            rounds++;
            fmessage = "Perfect \(randomnum). \nYou earned \(score) pts \n "
            title1 = " Correct!"
            
            
        }
        else if ((randomnum >= sliderval - 10) && (randomnum <= sliderval + 10)) {
            
            if randomnum > sliderval {
                score = randomnum - sliderval
            }
            else {
                score = sliderval - randomnum;
            }
            fscore += score
            rounds++;
            fmessage = "Slider Value is \(sliderval). \nYou earned \(score) pts \n "
            title1 = " Correct!"
        }
        else {
            
            fmessage = "Your estimation  was  \(sliderval). \n Your final score is \(fscore)"
            title1 = "Wrong";
            fscore = 0; rounds = 1;
            
        }
        
        var alert = UIAlertController(title: title1, message: fmessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Play Again!", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
      
        
        randomnum = 1 + Int(arc4random_uniform(100));
        RandomLabel.text = randomnum.description;
        RoundLabel.text = rounds.description;
        ScoreLabel.text = fscore.description;

        
    }
    @IBAction func Slider(sender: UISlider) {
        sliderval = Int(sender.value);
        
        
    }

    @IBAction func Shuffle(sender: UIButton) {
        randomnum = 1 + Int(arc4random_uniform(100));
        RandomLabel.text = randomnum.description;
        
    }
}

