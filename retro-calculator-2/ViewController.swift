//
//  ViewController.swift
//  retro-calculator-2
//
//  Created by Christian on 1/30/16.
//  Copyright © 2016 Christian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = ""
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var results = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func clearPressed (btn: UIButton){
        btnSound.play()
        outputLbl.text = "0"
        currentOperation = Operation.Empty
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        playSound()
        
        
        if currentOperation != Operation.Empty {
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    results = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    results = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract{
                    results = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    results = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = results
                outputLbl.text = results
            }
            currentOperation = op
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

