//
//  DifficultyScreen.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/16/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class DifficultyScreen: UIViewController {
    
    var difficultyLevel = 0
    @IBAction func easyButton(_ sender: UIButton) {
        difficultyLevel = 1
    }
    
    @IBAction func hardButton(_ sender: UIButton) {
        difficultyLevel = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "difficultySegue" {
            let passageDifficultyInfo = segue.destination as! typingSpeed
            passageDifficultyInfo.passageDifficulty = difficultyLevel
        }
    }

}
