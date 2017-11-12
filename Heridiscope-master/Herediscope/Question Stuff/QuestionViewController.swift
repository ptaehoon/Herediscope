//
//  QuestionViewController.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var question: Question!
    var firstButton: UIButton = UIButton()
    var secondButton: UIButton = UIButton()
    var submitButton: UIButton = UIButton()
    var picker: UIPickerView = UIPickerView()
    var light: UIColor = UIColor(red: 0.788, green: 0.843, blue: 1.0, alpha: 1.0)
    var dark: UIColor = UIColor(red: 0.220, green: 0.576, blue: 0.93, alpha: 1.0)
    
    var types: [String] = ["Heterozygous", "Homozygous", "I don't know"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // Body Text
        let questionText = UITextView(frame: CGRect(x: 10, y: 50, width: view.frame.width - 20, height: (view.frame.height - 20) / 3))
        questionText.text = "Q: " + question!.text
        questionText.font! = UIFont(name: questionText.font!.fontName, size: 32)!
        questionText.isEditable = false
        view.addSubview(questionText)
        
        firstButton = UIButton(frame: CGRect(x: 20, y: ((view.frame.height - 20) / 3) + 40, width: view.frame.width - 40, height: (view.frame.height / 4) - view.frame.height / 6))
        firstButton.backgroundColor = light
        firstButton.setTitle(question!.options[0], for: .normal)
        firstButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        view.addSubview(firstButton)
        
        
        secondButton = UIButton(frame: CGRect(x: 20, y: ((view.frame.height - 20) / 3) + 150, width: view.frame.width - 40, height: (view.frame.height / 4) - view.frame.height / 6))
        secondButton.backgroundColor = light
        secondButton.setTitle(question!.options[1], for: .normal)
        secondButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        view.addSubview(secondButton)
        
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: (view.frame.width - picker.frame.width) / 2, y: view.frame.height * 2 / 3 - 50, width: picker.frame.width, height: picker.frame.height)
        picker.isUserInteractionEnabled = true
        view.addSubview(picker)
        
        print(question.options)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonClicked(_ sender: Any) {
        
        print("Button Press")
        let buf = sender as! UIButton
        buf.backgroundColor = dark
        if (buf == firstButton) {
            secondButton.backgroundColor = light
        } else {
            firstButton.backgroundColor = light
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
