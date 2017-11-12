//
//  ResultViewController.swift
//  Herediscope
//
//  Created by Taehoon Bang on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var percent: Double!
    var thePhenotype: Phenotype!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var diseaseTextLabel: UILabel!
    
    @IBOutlet weak var resultText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TEST")
        if (percent == -1.0) {
            resultText.text = "We cannot accurately predict a result given your inputs"
        } else {
        resultText.text = "There is a " + String(percent) + "% of having " + thePhenotype.name
        }
        resultTextView.text = thePhenotype.description;
        diseaseTextLabel.text = thePhenotype.name;
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "backHome", sender: self)
    }
    
}
