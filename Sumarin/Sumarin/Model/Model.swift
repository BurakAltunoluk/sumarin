//
//  Model.swift
//  Sumarin
//
//  Created by Burak Altunoluk on 14/07/2022.
//

import Foundation
import UIKit

struct Model {
    var randomNumberArray: Set<Int> = []
    var targetNumber: Int
    
    init() {
        
        while randomNumberArray.count < 10 {
            let currentRandomNumber = Int.random(in: 12...32)
            randomNumberArray.insert(currentRandomNumber)
        }
        
        var randomTwoSet: Set<Int> = []
        while randomTwoSet.count < 2 {
            randomTwoSet.insert(Array(randomNumberArray)[Int.random(in: 0...9)])
        }
        
        targetNumber = Array(randomTwoSet)[0] + Array(randomTwoSet)[1]
    }
}

