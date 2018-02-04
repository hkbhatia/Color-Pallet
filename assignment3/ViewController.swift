//
//  ViewController.swift
//  assignment3
//
//  Created by Hitesh Bhatia on 9/28/17.
//  Copyright © 2017 Hitesh Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        getData()
    }
    
    @IBOutlet weak var outputViewer: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redText: UITextField!
    @IBOutlet weak var greenText: UITextField!
    @IBOutlet weak var blueText: UITextField!
    @IBOutlet weak var finalColor: UIButton!
    
    var redValue: Float = 0.0
    var greenValue: Float = 0.0
    var blueValue: Float = 0.0
    
    func saveData(){
        UserDefaults.standard.setValue(redValue, forKey: "redValue")
        UserDefaults.standard.setValue(greenValue, forKey: "greenValue")
        UserDefaults.standard.setValue(blueValue, forKey: "blueValue")
    }
    
    func getData(){
        let defaults = UserDefaults.standard
        if let rValue = defaults.string(forKey: "redValue"), let gValue = defaults.string(forKey: "greenValue"), let bValue = defaults.string(forKey: "blueValue")  {
            redValue = Float(rValue)!
            greenValue = Float(gValue)!
            blueValue = Float(bValue)!
            
            self.generateColor()
            self.setTextFieldValues()
        }
    }
    
    func setTextFieldValues() {
        self.redText.text = String(redValue)
        self.greenText.text = String(greenValue)
        self.blueText.text = String(blueValue)
        self.redSlider.value = Float(redValue)
        self.greenSlider.value = Float(greenValue)
        self.blueSlider.value = Float(blueValue)
    }
    
    @IBAction func redText(_ sender: UITextField) {
        view.endEditing(false)
    }
    
    @IBAction func greenText(_ sender: UITextField) {
        view.endEditing(false)
    }
    
    @IBAction func blueText(_ sender: UITextField) {
        view.endEditing(false)
    }
    
    @IBAction func finalColor(_ sender: UIButton) {
        view.endEditing(true)
        if redText.text!.isEmpty || !isStringAFloat(string: redText.text!){
            callWarning(errorField: redText, fieldVal: 0)
        }else {
            redValue = Float(redText.text!)!
            redSlider.value = redValue
        }
        
        if greenText.text!.isEmpty || !isStringAFloat(string: greenText.text!){
            callWarning(errorField: greenText, fieldVal: 1)
        }else {
            greenValue = Float(greenText.text!)!
            greenSlider.value = greenValue
        }
        
        if blueText.text!.isEmpty || !isStringAFloat(string: blueText.text!){
            callWarning(errorField: blueText, fieldVal: 2)
        }else {
            blueValue = Float(blueText.text!)!
            blueSlider.value = blueValue
        }
        
        if redValue < 0.0 || redValue > 100.0{
            callWarning(errorField: redText, fieldVal: 0)
        }
        if greenValue < 0.0 || greenValue > 100.0{
            callWarning(errorField: greenText, fieldVal: 1)
        }
        
        if blueValue < 0.0 || blueValue > 100.0{
            callWarning(errorField: blueText, fieldVal: 2)
        }
        generateColor()
    }
    
    func isStringAFloat(string: String) -> Bool {
        return Float(string) != nil
    }
    
    func generateColor(){
        let floatRedVal = Double((redValue*255)/100)/Double(255)
        let floatGreenVal = Double((greenValue*255)/100)/Double(255)
        let floatBlueVal = Double((blueValue*255)/100)/Double(255)
        let myColor = UIColor(red:CGFloat(floatRedVal), green:CGFloat(floatGreenVal), blue:CGFloat(floatBlueVal), alpha:CGFloat(1.0))
        outputViewer.backgroundColor = myColor
        saveData()
    }
    
    func callWarning(errorField : UITextField, fieldVal : Int){
        let alertController = UIAlertController(title: "Color Pallet Warning", message:
            "Input is out of range for: \(String(describing: errorField.placeholder)), values will auto-change", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        switch fieldVal {
        case 0:
            if redValue > 100.0 {
                redValue = 100.0
            }else{
                redValue = 0.0
            }
        case 1:
            if greenValue > 100.0 {
                greenValue = 100.0
            }else{
                greenValue = 0.0
            }
        case 2:
            if blueValue > 100.0 {
                blueValue = 100.0
            }else{
                blueValue = 0.0
            }
        default:
            break
        }
    
        redText.text = String(redValue)
        greenText.text = String(greenValue)
        blueText.text = String(blueValue)
    }
    
    @IBAction func redSlider(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        redText.text = String(currentValue)
        redValue = currentValue
        generateColor()
    }
    
    @IBAction func greenSlider(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        greenText.text = String(currentValue)
        greenValue = currentValue
        generateColor()
    }
  
    @IBAction func blueSlider(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        blueText.text = String(currentValue)
        blueValue = currentValue
        generateColor()
    }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        let red =   CGFloat((rgbValue/255)*100) / 255
        let green = CGFloat((rgbValue/255)*100) / 255
        let blue =  CGFloat((rgbValue/255)*100) / 255
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

