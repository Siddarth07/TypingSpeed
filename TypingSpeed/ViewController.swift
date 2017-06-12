//
//  ViewController.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateTextPassage()
       // userTextField.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControlEvents.editingChanged)
        userTextField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        userTextField.delegate = self
        let outsideViewClick: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(outsideViewClick)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Exitting First Responder Status and Hiding Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        dismissKeyboard()
        userBeganTyping = false
    }
    
    
    
    //MARK: Creating Passage
    var attributesNotSet = true
    @IBOutlet weak var passageText: UITextView!
    func populateTextPassage() {
        if(attributesNotSet){
            passageText.isEditable = false
    
            attributesNotSet = false
        }
        let typingPassages = TypingPassages()
        passageText.text = typingPassages.retreivePassage(choiceNumber: Int(arc4random_uniform(2)))
 
    }
    
    
    
//MARK:AccuracyDetection
    func textFieldValueChanged(_ textField: UITextField) {
        if(userTextField.text == "Republicans" || userTextField.text == "Sense" || userTextField.text == "R" || userTextField.text == "S"){
            print("true")
        }
        else{print("false")}
    }

}

