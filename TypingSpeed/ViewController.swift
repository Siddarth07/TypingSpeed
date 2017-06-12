//
//  ViewController.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    //Function Call to Timer
    var numButtonPress=0;
    @IBOutlet weak var countdownText: UILabel!
    var numSeconds = 60;
    var timer = Timer()
    @IBOutlet weak var userTextField: UITextField!


    
    @IBAction func pressInUserTextField(_ sender: Any) {
        if(numButtonPress==0){
            numButtonPress += 1
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.implementCounter), userInfo: nil, repeats: true)
        }
        
    }
    
  
    func implementCounter(){
        numSeconds -= 1
        countdownText.text = String(numSeconds)
        if(numSeconds==0){
            timer.invalidate()
        }
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        numSeconds = 60
        countdownText.text = "60"
        timer.invalidate()
        
    }

}

