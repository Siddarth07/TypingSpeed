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
        //Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        //resigns firstresponderstatus
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
    
    //MARK: Creating Passage
    var attributesNotSet = true
    var passageNumber = Int(arc4random_uniform(2))
    let typingPassages = TypingPassages()
    var passageUse = ""
    @IBOutlet weak var passageText: UITextView!
    func populateTextPassage() {
        if(attributesNotSet){
            passageText.isEditable = false
            attributesNotSet = false
        }
        passageUse = typingPassages.retreivePassage(choiceNumber: passageNumber)
        passageText.text = passageUse
    }
    
    
    
//MARK:AccuracyDetection
    var indexPosition = 0;
    var numCorrect = 0;
    var numWrong = 0;
    func textFieldValueChanged(_ textField: UITextField) {
        let accuracyDetector = AccuracyDetection()
        if((userTextField.text?.characters.count)! > 0 && (userTextField.text?.characters.last!)! == " " && numSeconds > 0){
            let correct =  accuracyDetector.wordCorrect(choiceOfPassage: passageUse, userEnteredWord: userTextField.text!, indexPosition: indexPosition)
            if(correct){
                indexPosition += 1
                numCorrect+=1
                resetUserTextfield()
            }
            else{
                indexPosition += 1
                numWrong += 1
                resetUserTextfield()
            }
        }
        if(numSeconds == 0){
            print(numCorrect)
            print(numWrong)
        }
        
        
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        numSeconds = 60
        countdownText.text = "60"
        timer.invalidate()
        populateTextPassage()
        resetUserTextfield()
        dismissKeyboard()
        userBeganTyping = false
        passageNumber = Int(arc4random_uniform(2))
        indexPosition = 0;
    }
    func resetUserTextfield(){
        userTextField.text = ""
    }

}

