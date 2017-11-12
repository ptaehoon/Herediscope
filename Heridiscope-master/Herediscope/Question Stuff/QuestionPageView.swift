//
//  QuestionPageView.swift
//  pageViewBlog
//
//  Created by Jonathan Yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//
import UIKit

class QuestionView: UIViewController {
    
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // label
        let labelInst = UILabel()
        self.view.addSubview(labelInst)
        labelInst.text = question!.text
        labelInst.translatesAutoresizingMaskIntoConstraints = false
        labelInst.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        labelInst.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
