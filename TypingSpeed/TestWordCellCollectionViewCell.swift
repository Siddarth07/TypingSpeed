//
//  TestWordCellCollectionViewCell.swift
//  TypingSpeed
//
//  Created by Siddarth Kethireddy on 6/14/17.
//  Copyright © 2017 Siddarth Kethireddy. All rights reserved.
//

import UIKit

class TestWordCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sampleTextLabel: UILabel!
    
    func configure(with viewModel: TestWordViewModel) {
        sampleTextLabel.text = viewModel.text
        sampleTextLabel.textColor = viewModel.textColor
        sampleTextLabel.backgroundColor = viewModel.backgroundColor
    }
    
}
