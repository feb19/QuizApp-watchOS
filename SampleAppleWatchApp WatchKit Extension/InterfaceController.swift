//
//  InterfaceController.swift
//  SampleAppleWatchApp WatchKit Extension
//
//  Created by TakahashiNobuhiro on 2018/06/17.
//  Copyright © 2018 feb19. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var commonLabel: WKInterfaceLabel!
    @IBOutlet var questionLabel: WKInterfaceLabel!
    @IBOutlet var timerLabel: WKInterfaceTimer!
    @IBOutlet var button: WKInterfaceButton!
    @IBOutlet var resultLabel: WKInterfaceLabel!
    
    var correctAnswer: Int = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        newQuestion()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func newQuestion() {
        let x = Int(arc4random() % 120)
        let y = Int(arc4random() % 120)
        let a = x + y
        let b = x + y + Int(arc4random() % 30) + 1
        let c = x + y - Int(arc4random() % 30) - 1
        let s = [a,b,c].shuffled
        
        for index in 0..<s.count {
            if (s[index] == a) {
                correctAnswer = index
                break
            }
        }
        
        let font = UIFont.systemFont(ofSize: 42.0)
        let attributes = [NSAttributedStringKey.font: font]
        let attributedString = NSAttributedString(string: "\(x) + \(y)", attributes: attributes)
        commonLabel.setAttributedText(attributedString)
        
        questionLabel.setText("[A]\(s[0]) [B]\(s[1]) [C]\(s[2])")
        
        resultLabel.setHidden(true)
    }
    
    func correct() {
        WKInterfaceDevice.current().play(.success)
        resultLabel.setHidden(false)
        resultLabel.setText("⭕️")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.newQuestion()
        }
    }
    
    func incorrect() {
        WKInterfaceDevice.current().play(.failure)
        resultLabel.setHidden(false)
        resultLabel.setText("❌")
    }

    @IBAction func buttonWasTapped() {
        if correctAnswer == 0 {
            correct()
        } else {
            incorrect()
        }
    }
    @IBAction func bButtonWasTapped() {
        if correctAnswer == 1 {
            correct()
        } else {
            incorrect()
        }
    }
    @IBAction func cButtonWasTapped() {
        if correctAnswer == 2 {
            correct()
        } else {
            incorrect()
        }
    }
}
