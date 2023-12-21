//
//  ContentView.swift
//  Basic
//
//  Created by ANDRIANIAINA on 17/12/2023.
//
import SwiftUI

enum CalculatorButton: String {
    case one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8",
         nine = "9", zero = "0"
    
    case add = "+", subtract = "-", multiply = "x", divide = "/"
    case equal = "🟰", clear = "❌", decimal = ".", percentage = "⁒", negative = "-/+"
    
    case remove = "⌫"
}

struct ContentView: View {
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percentage, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.remove, .zero, .decimal, .equal]
    ]
    
    @State private var numberInit: String = "0"
    @State private var numberCalcule: String = ""
    @State private var calcule: Calcul = Calcul()

    
    var body: some View {
        ZStack {
            //Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Spacer()
                    
                    Text(self.numberInit)
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(.black)
                        .padding(.top, 100)
                }
                
                ForEach(buttons, id: \.self) { buttonRow in
                    HStack {
                        ForEach(buttonRow, id: \.self) { button in
                            Button(action: { // Action listener
                                self.handCliclk(letters: button.rawValue)
                            }, label: {
                                Text(button.rawValue)
                                    .font(.system(size: 35))
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .foregroundColor(self.textButtonColor(button: button))
                                    .background(self.colorButton(button))
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                            })
                        }
                    }
                }

            }
            .padding(18)
        }
    }
    
    //function find qui click
    func handCliclk(letters: String) -> Void {
        switch letters {
            case "❌"://suppr tt
                self.clear()
            
            case "🟰": //faire des calcule
                print(numberInit)
                numberInit = calcule.evaluateExpression(numberCalcule)
                //initialisena amleh nouvelle valeur
                numberCalcule = numberInit
            
            case "⌫": //faire des suppression
                numberInit = self.removeLastCharacter(from: numberInit)
                numberCalcule = numberInit
            
            case "⁒": //pourcentage
                numberInit = calcule.pourcentage(numberCalcule)
            
            case "-/+": //ajoute negative avant mots
                numberInit = self.addMinus(numberInit)
                numberCalcule = numberInit
            
            default:
                numberCalcule += letters
                numberInit = numberCalcule
            }
        
    }
    
    //remove derniere caractere
    func removeLastCharacter(from input: String) -> String {
        var modifiedString = input
        if input.count > 1 {
            modifiedString.removeLast()
        }else{
            modifiedString = "0"
        }
        return modifiedString
    }
    
    //ajout moins
    func addMinus(_ input: String) -> String {
        if !input.hasPrefix("-") {
            return "-" + input
        }
        return input
    }
    
    
    //initialiser a 0 de la valeur
    func clear() -> Void {
        numberInit = "0"
        numberCalcule = ""
    }
    
    //function setColeur button
    func colorButton(_ button: CalculatorButton) -> Color {
        switch button {
        case .divide, .multiply, .subtract, .add, .equal:
            return Color.orange
            
        case .clear, .negative, .percentage, .remove:
            return Color(.systemGray6)
            
        default:
            return Color.gray
        }
    }
    
    //function mi sette coleur du texte
    func textButtonColor(button: CalculatorButton) -> Color {
        switch button {
            case .clear, .negative, .percentage:
                return Color.black
                
            case .remove:
                return Color.red
                
            default:
                return Color.white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
