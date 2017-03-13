//
//  ViewController.swift
//  Calculator
//
//  Created by 周围 on 2017/2/23.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
//        print("\(digit) was called")
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue:Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text! = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π":
                displayValue = Double.pi
            case "√":
                let operand = Double(display.text!)!
                displayValue = sqrt(operand)
            default:
                break
            }
        }
    }
}

