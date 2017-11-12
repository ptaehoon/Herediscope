//
//  QuestionnaireViewController.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/28/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var thePhenotype: Phenotype = Phenotype()
    var light: UIColor = UIColor(red: 0.788, green: 0.843, blue: 1.0, alpha: 1.0)
    var dark: UIColor = UIColor(red: 0.220, green: 0.576, blue: 0.93, alpha: 1.0)
    
    var pages = [QuestionViewController]()
    let pageControl = UIPageControl()
    
    var double: Double = 0.0
    var parents: [Genotype] = []
    var child: Gender = Gender.Female
    var percent: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        let initialPage = 0
        
        
        for question in thePhenotype.questions {
            let temp: QuestionViewController = QuestionViewController()
            temp.question = question
            pages.append(temp)
        }
        let temp = QuestionViewController()
        temp.question = thePhenotype.questions[0]
        temp.view.isHidden = true
        pages.append(temp)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        // pageControl
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
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
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController as! QuestionViewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
//                return self.pages[0]
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController as! QuestionViewController) {
            if viewControllerIndex < self.pages.count - 1{
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in arra0y
                submit()
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set  the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0] as! QuestionViewController) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    public func submit() {
        var i = 0
        for page in pages {
            print(page.firstButton.backgroundColor == dark)
            if (i < pages.count - 1) {
                if (i == 3) {
                    if(pages[i].firstButton.backgroundColor == dark) {
                        child = Gender.Male
                    } else {
                        child = Gender.Female
                    }
                } else if (pages[i].firstButton.backgroundColor == dark) {
                    switch page.picker.delegate?.pickerView!(page.picker, titleForRow: 0, forComponent: page.picker.selectedRow(inComponent: 0)) as! String {
                    case "Heterozygous":
                        parents.append(Genotype.Heterozygous)
                    case "Homozygous":
                        parents.append(Genotype.Homozygous)
                    default:
                        parents.append(Genotype.Expressed)
                    }
                } else if(pages[i].secondButton.backgroundColor == dark){
                    parents.append(Genotype.NonExpressed)
                } else {
                    print("This is why it's not working")
                    parents.append(Genotype.NotSet)
                }
            }
            i = i + 1
        }
        switch thePhenotype.type {
        case .AutosomalDominant:
            let disease = AutosomalDominant(parentOne: parents[0], parentTwo: parents[1])
            percent = disease.percentage()
        case .AutosomalRecessive:
            let disease = AutosomalRecessive(parentOne: parents[0], parentTwo: parents[1])
            percent = disease.percentage()
        case .SexLinkedDominant:
            let disease = SexLinkedDominant(parentOne: parents[0], parentTwo: parents[1], childv: child)
            percent = disease.percentage()
        case .SexLinkedRecessive:
            let disease = SexLinkedDominant(parentOne: parents[0], parentTwo: parents[1], childv: child)
            percent = disease.percentage()
        default:
            print("rip")
        }
        print("THE PERCENT IS: " + String(percent))
        print(parents)
        performSegue(withIdentifier: "submitAnswers", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loadingViewController = segue.destination as? LoadingViewController {
            loadingViewController.percent = percent
            loadingViewController.thePhenotype = thePhenotype
        }
    }
}
