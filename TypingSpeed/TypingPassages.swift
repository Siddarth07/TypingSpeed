//
//  TypingPassages.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import Foundation
class TypingPassages{

    func retreivePassage() -> String {
        var commonWordStringArray = [String]()
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: "1-1000", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                commonWordStringArray = data.components(separatedBy: "\n")
            }
        } catch {
            // do something with Error
            print("fileProbs")
        }
        var totalNumWords = 0
        var passageString = ""
        while(totalNumWords<300) {
            let randomNum:UInt32 = arc4random_uniform(1000)
            passageString = passageString + commonWordStringArray[Int(randomNum)] + " "
            totalNumWords += 1
        }
        return passageString
    }
}
