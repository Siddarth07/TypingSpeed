//
//  ViewController.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var countdownText: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var textCollection: UICollectionView!
   
    let typingPassages = TypingPassages()
    var numSeconds = 15
    var timer = Timer()
    var userBeganTyping = false
    var attributesNotSet = true
    var passageNumber = Int(arc4random_uniform(2))
    var passageUse = ""
    var indexPosition = 0;
    var numCorrect = 0;
    var numWrong = 0;
    var wordData = [TestWord]()
    var wordArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateTextPassage()
        userTextField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        userTextField.delegate = self
        let outsideViewClick: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(outsideViewClick)
        let flowLayout = textCollection.collectionViewLayout as? FlowLayout
        flowLayout?.estimatedItemSize = CGSize(width: 20, height: 20)
    
    }
    
    func checkToChangeScreen(){
        self.performSegue(withIdentifier: "WPMScreenSegue", sender: self)
        
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
           resetsForScreenReturn()
            checkToChangeScreen()
        }
    }
    
    //MARK: Creating Passage
    func populateTextPassage() {
        let passage = typingPassages.retreivePassage()
        wordArray = passage.components(separatedBy: " ")
        wordData = wordArray.map { TestWord(word: $0) }
        textCollection.reloadData()
    }
    
    
    
    //MARK:AccuracyDetection
    func textFieldValueChanged(_ textField: UITextField) {
//        accuracyDetector.trackNumChars()
//        
        if((userTextField.text?.characters.count)! > 0 && (userTextField.text?.characters.last!)! == " " && numSeconds > 0) {
            TestWord(word: wordArray[indexPosition]).setAnswer(String((userTextField.text!).characters.dropLast()))
            if(TestWord(word: wordArray[indexPosition]).isCorrect){
                numCorrect += 1
                resetUserTextfield()
            }
            else {
                numWrong += 1
                resetUserTextfield()
            }
            indexPosition += 1
            
//            let correct =  accuracyDetector.wordCorrect(choiceOfPassage: passageUse, userEnteredWord: userTextField.text!, indexPosition: indexPosition)
//            if(correct) {
//                indexPosition += 1
//                numCorrect+=1
//                resetUserTextfield()
//            }
//            else {
//                indexPosition += 1
//                numWrong += 1
//                resetUserTextfield()
//            }
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
        indexPosition = 0
    }
    
    func resetsForScreenReturn(){
        numSeconds = 60
        countdownText.text = "60"
        timer.invalidate()
        populateTextPassage()
        resetUserTextfield()
        dismissKeyboard()
        userBeganTyping = false
        indexPosition = 0
    }
    
    func resetUserTextfield(){
        userTextField.text = ""
    }
    

    //MARK: Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WPMScreenSegue" {
            let WPMInfo = segue.destination as! WPMScreen
            WPMInfo.numCorrectDisplay = numCorrect
            WPMInfo.numWrongDisplay = numWrong
            
        }

    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let word = wordData[index]
        let cell = textCollection.dequeueReusableCell(withReuseIdentifier: "sampleText", for: indexPath) as! TestWordCellCollectionViewCell
        cell.configure(with: word)
        return cell 
    }
}

