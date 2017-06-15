//
//  TestWord.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/14/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import Foundation
import UIKit

class TestWord {
    
    let correctWord: String
    var answer: String?
    var indexPathBool: Bool = false
    
    public init(word: String) {
        self.correctWord = word
    }
    
    func setAnswer(_ answer: String) {
        self.answer = answer
      
    }
    
    func indexPathBool(_ indexPathBool: Bool) {
        self.indexPathBool = indexPathBool
    }
    
    var isCorrect: Bool {
        guard let answer = answer else {
            return false
        }
        return (answer == correctWord)
    }

   
    
}

protocol TestWordViewModel {
    
    var text: String { get }
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
}


extension TestWord: TestWordViewModel {
    
    var text: String {
        return self.correctWord
    }
    
    var textColor: UIColor {
        return UIColor.black
    }
    
    var backgroundColor: UIColor {
        if(indexPathBool) {
            return UIColor.lightGray
        }
        guard answer != nil else { return UIColor.white }
        return isCorrect ? UIColor.green : UIColor.red
        
    }
    
}
