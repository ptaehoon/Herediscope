//
//  LoadingViewController.swift
//  Herediscope
//
//  Created by Taehoon Bang on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIImageView!
    
    var percent: Double!
    var thePhenotype: Phenotype!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let when = DispatchTime.now() + 3
        
        animationView.animationImages = [#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide2"),#imageLiteral(resourceName: "slide3"),#imageLiteral(resourceName: "slide4"),#imageLiteral(resourceName: "slide5"),#imageLiteral(resourceName: "slide6"),#imageLiteral(resourceName: "slide7"),#imageLiteral(resourceName: "slide8"),#imageLiteral(resourceName: "slide9"),#imageLiteral(resourceName: "slide10"),#imageLiteral(resourceName: "slide11"),#imageLiteral(resourceName: "slide12"),#imageLiteral(resourceName: "slide13"),#imageLiteral(resourceName: "slide14"),#imageLiteral(resourceName: "slide15"),#imageLiteral(resourceName: "slide16"),#imageLiteral(resourceName: "slide17"),#imageLiteral(resourceName: "slide18"),#imageLiteral(resourceName: "slide19")]
        animationView.animationDuration = 1;
        animationView.animationRepeatCount = 3;
        animationView.startAnimating();
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.performSegue(withIdentifier: "toResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.percent = percent
            resultViewController.thePhenotype = thePhenotype
        }
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
    
}
