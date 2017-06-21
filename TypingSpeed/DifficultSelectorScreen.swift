//
//  DifficultSelectorScreen.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/16/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class DifficultSelectorScreen: UIViewController {

    var difficultySelector = 0
    
    @IBAction func easyButton(_ sender: Any) {
        difficultySelector = 1
    }
    
    @IBAction func hardButton(_ sender: Any) {
        difficultySelector = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "difficultySegue") {
            let passageSelector = segue.destination as! typingSpeed
            passageSelector.passageNumber = difficultySelector
            
        }
    }

}
