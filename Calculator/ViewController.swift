//
//  ViewController.swift
//  Calculator
//
//  Created by Ryan Machay on 7/12/15.
//  Copyright (c) 2015 Ryan Machay. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false

    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
        
        if userIsTyping {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTyping {
            Enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1}
        case "÷": performOperation { $1 / $0}
        case "+": performOperation { $0 + $1}
        case "-": performOperation { $1 - $0}
        case "√": performOperation { sqrt($0) }
        default: break
        }
        
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            Enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            Enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func Enter() {
        userIsTyping = false
        operandStack.append(displayValue)
        println("operandStack \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
    
    }

