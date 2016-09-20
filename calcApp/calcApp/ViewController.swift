//
//  ViewController.swift
//  calcApp
//
//  Created by Vitaly Sacred on 15/09/16.
//  Copyright © 2016 Vitaly Sacred. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    var runningNumbers = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    @IBOutlet weak var outPutLbl: UILabel!
    
    @IBAction func onDividePress(sender: AnyObject) {
        precessedOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPress(sender: AnyObject) {
        precessedOperation(operation: .Multiply)
    }
    @IBAction func onAddPress(sender: AnyObject) {
        precessedOperation(operation: .Add)
    }
    @IBAction func onSubstractPress(sender: AnyObject) {
        precessedOperation(operation: .Substract)
    }

    @IBAction func onEqulsPressed (sender: AnyObject) {
        precessedOperation(operation: currentOperation)
    }


    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumbers += "\(sender.tag)"
        outPutLbl.text = runningNumbers
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func precessedOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumbers != "" {
                rightValStr = runningNumbers
                runningNumbers = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outPutLbl.text = result
                
            }
            currentOperation = operation
        } else {
            leftValStr = runningNumbers
            runningNumbers = ""
            currentOperation = operation
        }
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        
            }
        outPutLbl.text = "0"
        
        
    }
}



