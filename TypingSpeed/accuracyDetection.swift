//
//  accuracyDetection.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import Foundation
class AccuracyDetection{
    
    func currentCorrectWord(passageString: String, indexPosition: Int) -> String{
        let wordArray = passageString.components(separatedBy: " ")
        print(wordArray[indexPosition])
        return wordArray[indexPosition]
        
    }
  
    
    
    func wordCorrect(choiceOfPassage: String, userEnteredWord: String, indexPosition: Int) -> Bool{
        var wordBool = false;
        let userEnteredWord = String(userEnteredWord.characters.dropLast())
        print(userEnteredWord)
        
        let correctWord = currentCorrectWord(passageString: choiceOfPassage, indexPosition: indexPosition)
        if(correctWord == userEnteredWord){
            wordBool = true;
        }
        
        return wordBool
    }
    
    
    var numChar = 0
    
    func trackNumChars() {
        numChar += 1
    }
    
    func resetNumChars(){
        numChar = 0
    }
}
