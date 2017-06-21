//
//  CalculateNetWPM.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/15/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import Foundation
class charAccuracyInformation {
    
    let correctWord: String
    let userEnteredWord: String
    var correctWrongArr: [Int] = [0,0]
    
    public init(correctWord: String, userEnteredWord: String) {
        self.correctWord = correctWord
        self.userEnteredWord = userEnteredWord
    }
    
    
    func calculateNumCharsWrong() -> Array<Int> {
        let correctArr = correctWord.characters.map { String ($0) }
        let userEnteredArr = userEnteredWord.characters.map { String ($0) }
        for i in 0 ..< min(userEnteredArr.count, correctArr.count) {
            if (userEnteredArr[i] == correctArr[i]) {
                correctWrongArr[0] += 1
            }
            else {
                correctWrongArr[1] += 1
            }
        }
        correctWrongArr[1] += abs(correctArr.count - userEnteredArr.count)
        return correctWrongArr
    }
}
