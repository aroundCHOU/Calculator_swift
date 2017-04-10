//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 周围 on 2017/3/14.
//
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator : Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations : Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "+" : Operation.binaryOperation({$0 + $1}),
        "−" : Operation.binaryOperation({$0 - $1}),
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "±" : Operation.unaryOperation({ -$0 }),
        "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOpenation = PendingBinaryOperation(function:function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
            
        }
    }
    
    mutating private func performPendingBinaryOperation() {
        if pendingBinaryOpenation != nil && accumulator != nil {
            accumulator = pendingBinaryOpenation!.perform(with: accumulator!)
            pendingBinaryOpenation = nil
        }
    }
    
    private var pendingBinaryOpenation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand:Double) {
        accumulator = operand
    }
    
    var result : Double? {
        get {
            return accumulator
        }
    }
    
}
