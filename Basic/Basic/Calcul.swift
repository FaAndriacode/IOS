//
//  Calcul.swift
//  Basic
//
//  Created by ANDRIANIAINA on 21/12/2023.
//
import Foundation

class Calcul {
    
    func evaluateExpression(_ expression: String) -> String {
        let processedExpression = expression.replacingOccurrences(of: "x", with: "*")

        let expression = NSExpression(format: processedExpression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            return String(result)
        } else {
            return "0"
        }
    }
    
    
    func pourcentage(_ expression: String) -> String {
        if let result = Double(expression){
            let temp = result * 0.01
            return String(temp)
        }else{
            return "0"
        }
    }


}
