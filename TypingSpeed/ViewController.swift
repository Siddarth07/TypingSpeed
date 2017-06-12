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
        populateTextPassage()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    //MARK: Function Call to Timer
    @IBOutlet weak var countdownText: UILabel!
    var numSeconds = 60
    var timer = Timer()
    @IBOutlet weak var userTextField: UITextField!
    
    var userBeganTyping = false
    @IBAction func pressInUserTextField(_ sender: Any) {
        if(!(userBeganTyping)){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(implementCounter), userInfo: nil, repeats: true)
            userBeganTyping = true
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
        populateTextPassage()
        userTextField.text = ""
    }
    
    
    
    //MARK: Creating Passage
    var attributesSet = true
    @IBOutlet weak var passageText: UITextView!
    func populateTextPassage() {
        if(attributesSet){
            passageText.isEditable = false
    
            attributesSet = false
        }
        let typingPassages = TypingPassages()
        passageText.text = typingPassages.retreivePassage(choiceNumber: Int(arc4random_uniform(2)))
 
    }
    
    
    
    

}

