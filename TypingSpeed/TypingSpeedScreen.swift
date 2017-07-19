//
//  ViewController.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class TypingSpeedScreen: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var countdownText: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var textCollection: UICollectionView!
    
    let typingPassages = TypingPassages()
    var numSeconds = 7
    var timer = Timer()
    var userBeganTyping = false
    var attributesNotSet = true
    var passageDifficulty = 0
    var passageUse = ""
    var indexPosition = 0
    var numWordsCorrect = 0
    var numWordsWrong = 0
    var correctWrongChars = [0,0]
    var wordData = [TestWord]()
    var wordArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageResets()
        // Do any additional setup after loading the view, typically from a nib.
        print(passageDifficulty)
        populateTextPassage()
        userTextField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        userTextField.delegate = self
        let outsideViewClick: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TypingSpeedScreen.dismissKeyboard))
        view.addGestureRecognizer(outsideViewClick)
        let flowLayout = textCollection.collectionViewLayout as? FlowLayout
        flowLayout?.estimatedItemSize = CGSize(width: 20, height: 20)
    }
    
    //MARK: Exitting First Responder Status and Hiding Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    
    func implementCounter() {
        numSeconds -= 1
        countdownText.text = String(numSeconds)
        if(numSeconds==0){
            numSeconds=60
            timer.invalidate()
            ChangeScreen()
        }
    }
    
    func ChangeScreen(){
        self.performSegue(withIdentifier: "WPMScreenSegue", sender: self)
        
    }
    
    //MARK: Creating Passage
    func populateTextPassage() {
        let passage = typingPassages.retreivePassage(difficultyLevel: passageDifficulty)
        wordArray = passage.components(separatedBy: " ")
        wordData = wordArray.map { TestWord(word: $0) }
        textCollection.reloadData()
    }

    //MARK:AccuracyDetection
    func textFieldValueChanged(_ textField: UITextField) {
        if((userTextField.text?.characters.count)! > 0 && (userTextField.text?.characters.last!)! == " " && numSeconds > 0 && indexPosition < 300) {
            let answer = String(userTextField.text!.characters.dropLast())
            wordData[indexPosition].setAnswer(answer)
            wordData[indexPosition + 1].indexPathBool(true)
            if(wordData[indexPosition].isCorrect) {
                numWordsCorrect += 1
                resetUserTextfield()
            }
            else {
                numWordsWrong += 1
                resetUserTextfield()
            }
            let wordCharCorrectWrongArr = charAccuracyInformation(correctWord: wordData[indexPosition].correctWord , userEnteredWord: answer).calculateNumCharsWrong()
            correctWrongChars[0] += wordCharCorrectWrongArr[0]
            correctWrongChars[1] += wordCharCorrectWrongArr[1]
            indexPosition += 1
            wordData[indexPosition].indexPathBool(false)
            let indexPathToScroll = IndexPath(row: indexPosition, section: 0)
            textCollection.scrollToItem(at: indexPathToScroll, at: UICollectionViewScrollPosition.top, animated: true)
            textCollection.reloadData()
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        numSeconds = 7
        countdownText.text = "60"
        timer.invalidate()
        populateTextPassage()
        resetUserTextfield()
        dismissKeyboard()
        userBeganTyping = false
        indexPosition = 0
        numWordsCorrect = 0
        numWordsWrong = 0
        correctWrongChars = [0,0]
    }

    func pageResets() {
        numSeconds = 7
        countdownText.text = "60"
        timer.invalidate()
        populateTextPassage()
        resetUserTextfield()
        dismissKeyboard()
        userBeganTyping = false
        indexPosition = 0
        numWordsCorrect = 0
        numWordsWrong = 0
        correctWrongChars = [0,0]
    }
    
    func resetUserTextfield() {
        userTextField.text = ""
    }

    //MARK: Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WPMScreenSegue" {
            let WPMInfo = segue.destination as! WPMScreen
            WPMInfo.numCorrectDisplay = numWordsCorrect
            WPMInfo.numWrongDisplay = numWordsWrong
            WPMInfo.charArray = correctWrongChars
        }
    }

    @IBAction func unwindToTypingSpeed(segue: UIStoryboardSegue) {
        
    }
}

extension TypingSpeedScreen: UICollectionViewDataSource {
    
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

