//
//  DetailedViewController.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var disease: DiseaseDict!
    
    @IBOutlet weak var diseaseTitle: UITextView!
    
    @IBOutlet weak var diseaseDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        diseaseTitle.text = disease.name
        diseaseDescription.text = "    " + disease.description
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

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
