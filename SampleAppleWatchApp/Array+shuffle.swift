//
//  Array+shuffle.swift
//  SampleAppleWatchApp
//
//  Created by TakahashiNobuhiro on 2018/06/18.
//  Copyright © 2018 feb19. All rights reserved.
//

import Foundation
extension Array {
    
    mutating func shuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
    var shuffled: Array {
        var copied = Array<Element>(self)
        copied.shuffle()
        return copied
    }
}
