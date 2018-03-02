import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var fiveCharMaxTextField: UITextField!
    
    @IBOutlet var toogleInputTextField: UITextField!
    private var allowUserInput:Bool!
    
    @IBOutlet var currencyFormatTextField: UITextField!
    let defaultCurrencyText = "$0.00"
    let backspace = ""
    let oneDecimalPlace = 10
    var intValue = 0
    var lastNumberPressed:Int!
    
    func increaseRealValue()
    {
        intValue *= oneDecimalPlace
        intValue += lastNumberPressed
    }
    
    func decreaseRealValue()
    {
        intValue = intValue / oneDecimalPlace
    }
    
    func isNumericChar(charPressed:String) -> Bool
    {
        let asciiValue = UnicodeScalar(charPressed)!.value
        if asciiValue >= 48 && asciiValue <= 57
        {
            return true
        }
        return false
    }
    
    func convertToCurrency(buttonPressed:String) -> String
    {
        if buttonPressed == backspace
        {
            decreaseRealValue()
        }
        else if isNumericChar(charPressed: buttonPressed)
        {
            lastNumberPressed = Int(buttonPressed)!
            increaseRealValue()
        }
        let realValue = Double(intValue) / 100
        return String(format:"$%0.2f", realValue)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var allowTextFieldChange = true
        switch textField
        {
        case fiveCharMaxTextField:
            allowTextFieldChange = hasLessThanFiveChars(inputString:string,charCount: range)
        case toogleInputTextField:
            allowTextFieldChange = allowUserInput
        case currencyFormatTextField:
            allowTextFieldChange = false
            currencyFormatTextField.text =  convertToCurrency(buttonPressed:string)
        default:
            break
        }
        return allowTextFieldChange
    }
    
    
    @IBAction func toogleInputSwitch(_ sender: UISwitch)
    {
        allowUserInput = sender.isOn ? true : false
    }
    
    func hasLessThanFiveChars(inputString:String, charCount:NSRange) -> Bool
    {
        return (inputString == "" || charCount.location < 5) ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fiveCharMaxTextField.delegate = self
        toogleInputTextField.delegate = self
        currencyFormatTextField.delegate = self
        currencyFormatTextField.textAlignment = .right
        currencyFormatTextField.text = defaultCurrencyText
    }
}



