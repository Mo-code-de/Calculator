//
//  ViewController.swift
//  Calculator
//
//  Created by Morris Grothe on 30.07.24.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorResult: UILabel!
    @IBOutlet weak var calculatorWorkings: UILabel!
    
    var workings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    //Change all variables to blank.
    func clearAll(){
        workings = ""
        calculatorResult.text = ""
        calculatorWorkings.text = ""
    }
    
    //Write the input into workings and write it to the screen.
    func addToWorkings(value: String){
        workings = workings + value
        calculatorWorkings.text = workings
    }
    
    @IBAction func clearButton(_ sender: Any) {
        clearAll()
    }
    @IBAction func backspaceButton(_ sender: Any) {
        if(!workings.isEmpty){
            workings.removeLast()
            calculatorWorkings.text = workings
        }
    }
    @IBAction func equalsButton(_ sender: Any) {
        if(validInput()){
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResult.text = resultString
        } else {
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math based on input",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert,animated: true, completion: nil)
        }
    }
    //Check if input is valid. The first and last chars in the input-string cannot be a special char.
    func validInput() -> Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings {
            if(specialCharacter(char: char)) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes {
            if(index == 0){
                return false
            }
            if(index == workings.count - 1){
                return false
            }
            if(previous != -1){
                if(index - previous == 1){
                    return false
                }
            }
            previous = index
        }
        return true
    }
    
    //Defines what a special Character is.
    func specialCharacter (char: Character) -> Bool {
        if(char == "*") {
            return true
        }
        if(char == "/") {
            return true
        }
        if(char == "+") {
            return true
        }
        if(char == "-") {
            return true
        }
        return false
    }
    
    //Formating the result-string.
    func formatResult(result: Double) -> String {                   //Formating double to String
        if(result.truncatingRemainder(dividingBy: 1) == 0){         //Check if result is a whole number by dividing                                                                 through 1
             return String (format: "%.0f", result)                 //If result = whole number, show zero decimal places.
        } else {
            return String (format: "%.2f", result)                  //If result != wohle number, show two decimal places.
        }
    }
    
    //define all buttons/values (linked to the storyboard
    @IBAction func zeroButton(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func oneButton(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func twoButton(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func threeButton(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func forButton(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func fiveButton(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func sixButton(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func sevenButton(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func eightButton(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func nineButton(_ sender: Any) {
        addToWorkings(value: "9")
    }
    @IBAction func multiplyButton(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func divideButton(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func additionButton(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func substractionButton(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func percentageButton(_ sender: Any) {
        addToWorkings(value: "%")
    }
    
    
    
}

