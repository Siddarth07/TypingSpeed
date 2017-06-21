//
//  TimerImplementation.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/12/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class TimerImplementation: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var userBeganTyping = false
    var timer = Timer()
    var numSeconds = 60
    @IBOutlet weak var countdownText: UILabel!
    func pressInUserTextField(_ sender: Any) {
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


}
