//
//  ViewController.swift
//  threeSlidersApp
//
//  Created by Roman on 01.10.23.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}



final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var redCurrentValue: UILabel!
    @IBOutlet weak var greenCurrentValue: UILabel!
    @IBOutlet weak var blueCurrentValue: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var textFieldRed: UITextField!
    @IBOutlet weak var textFieldGreen: UITextField!
    @IBOutlet weak var textFieldBlue: UITextField!
    
    
    var forBackgroundcolor: UIColor!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldRed.delegate = self
        textFieldGreen.delegate = self
        textFieldBlue.delegate = self
        
        addDoneButtonToKeyboard()
        
        splitColor()
        mainViewSetup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        updateColor()
        
        switch sender {
        case redSlider:
            redCurrentValue.text = formatSliderValue(redSlider.value)
            textFieldRed.text = redCurrentValue.text
        case greenSlider:
            greenCurrentValue.text = formatSliderValue(greenSlider.value)
            textFieldGreen.text = greenCurrentValue.text
        default:
            blueCurrentValue.text = formatSliderValue(blueSlider.value)
            textFieldBlue.text = blueCurrentValue.text
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        delegate?.setColor(mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = Float(textField.text ?? "") ?? nil , (0...1).contains(value) else {
            showAlert(
                with: "Не верный формат",
                message: "Введите число от 0 до 1"
            )
            return
        }
            switch textField {
            case textFieldRed:
                redSlider.value = value
                redCurrentValue.text = formatSliderValue(value)
            case textFieldGreen:
                greenSlider.value = value
                greenCurrentValue.text = formatSliderValue(value)
            default:
                blueSlider.value = value
                blueCurrentValue.text = formatSliderValue(value)
            }
            updateColor()
    }
    
    private func mainViewSetup() {
        mainView.layer.cornerRadius = 30
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func updateColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func formatSliderValue(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
    private func splitColor() {
        let forSliderColor = CIColor(color: forBackgroundcolor)
        
        redSlider.value = Float(forSliderColor.red)
        greenSlider.value = Float(forSliderColor.green)
        blueSlider.value = Float(forSliderColor.blue)
        
        redCurrentValue.text = formatSliderValue(redSlider.value)
        greenCurrentValue.text = formatSliderValue(greenSlider.value)
        blueCurrentValue.text = formatSliderValue(blueSlider.value)
        
        textFieldRed.text = formatSliderValue(redSlider.value)
        textFieldGreen.text = formatSliderValue(greenSlider.value)
        textFieldBlue.text = formatSliderValue(blueSlider.value)
    }
    
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "ага понял ", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func addDoneButtonToKeyboard() {
        let numberToolbar = UIToolbar()
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        ]
        numberToolbar.sizeToFit()

        textFieldRed.inputAccessoryView = numberToolbar
        textFieldGreen.inputAccessoryView = numberToolbar
        textFieldBlue.inputAccessoryView = numberToolbar
    }

    @objc func doneButtonAction() {
        view.endEditing(true)
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    
}
