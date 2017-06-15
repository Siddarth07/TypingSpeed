//
//  WPMScreen.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/13/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class WPMScreen: UIViewController {
 
    var numCorrectDisplay = 0
    var numWrongDisplay = 0
    
    @IBOutlet weak var WPMDisplay: UILabel!
    override func viewDidLoad() {        
        super.viewDidLoad()
        WPMDisplay.text = String(numCorrectDisplay)
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

}
