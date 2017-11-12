//
//  YourViewController.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/27/17. 
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class YourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var phenoTypeCache: [Phenotype] = []
    var filteredData: [Phenotype] = []
    var index: Int = 0
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        searchBar.isHidden = true;
        searchBar.isUserInteractionEnabled = false;
        searchBar.delegate = self;
        print("View Loaded")
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Making questionnaire")
        index = indexPath.row
        performSegue(withIdentifier: "toQuestionnaire", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? QuestionnaireViewController {
            if isSearching {
                viewController.thePhenotype = filteredData[index]
            } else {
                viewController.thePhenotype = phenoTypeCache[index]
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return array.size
        if isSearching == false {
            return phenoTypeCache.count
        } else {
            return filteredData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath);
        if isSearching == false {
            cell.textLabel?.text = phenoTypeCache[indexPath.row].name;
        } else {
            cell.textLabel?.text = filteredData[indexPath.row].name;
        }
        print("making cell")
        return cell;
    }
    
    
    func loadData() {
        print("Trying to fetch Data")
        let customSerialQueue = DispatchQueue(label: "popularLoad")
        customSerialQueue.async {
            if let path = Bundle.main.path(forResource: "phenotypes", ofType: "json") {
                print("Connected to file")
                let jsonResult = self.getJSON(path: path)
                // do stuff yy
                print("Found Data")
                print(jsonResult)
                for result in jsonResult.arrayValue {
                    
                    if (result["child"].boolValue == false) {
                        let name = result["name"].stringValue
                        let description = result["description"].stringValue
                        var questions: [Question] = []
                        for question in result["questions"].arrayValue {
                            let temp = Question(name: question["name"].stringValue, type: question["type"].stringValue, options: question["options"].arrayValue.map { $0.stringValue}, text: question["text"].stringValue)
                            questions.append(temp)
                        }
                        let answered = result["answered"].boolValue
                        let buf = result["type"].stringValue
                        var type: traitType = traitType.AutosomalDominant
                        switch buf {
                        case "AutosomalDominant":
                            type = traitType.AutosomalDominant
                        case "AutosomalRecessive":
                            type = traitType.AutosomalRecessive
                        case "SexLinkedDominant":
                            type = traitType.SexLinkedDominant
                        case "SexLinkedRecessive":
                            type = traitType.SexLinkedRecessive
                        default:
                            type = traitType.AutosomalDominant
                        }
                        self.phenoTypeCache.append(Phenotype(n: name, d: description, q: questions, a: answered, t: type))
                        print("Recording Data")
                        print(self.phenoTypeCache)
                    }
                }
            }
            print("Reloading Tableview")
            DispatchQueue.main.async {
                self.phenoTypeCache.sort { $0.name < $1.name }
                self.tableView.reloadData()
            }
        }
    }
    
    private func getJSON(path: String) -> JSON {
        let url = URL(fileURLWithPath: path)
        print(url)
        do {
            let data = try Data(contentsOf: url)
            print(data)
            print("Got Data")
            let json = try JSON(data: data)
            print("Got json")
            return json
        } catch {
            print("JSON failed to load")
            return JSON.null
        }
    }
    
    
    
    //MARK: Search Bar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredData = phenoTypeCache.filter({ $0.name.range(of: searchBar.text!, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil })
            tableView.reloadData()
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func searchPressed(_ sender: Any) {
        searchBar.isHidden = false;
        searchBar.isUserInteractionEnabled = true;
        searchBar.showsCancelButton = true;
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true;
        searchBar.isUserInteractionEnabled = false;
        searchBar.text = "";
    }
    
    
    
    
}

