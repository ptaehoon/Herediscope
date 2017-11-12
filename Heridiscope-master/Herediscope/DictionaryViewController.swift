//
//  DictionaryViewController.swift
//  Herediscope
//
//  Created by Jonathan yue on 10/27/17.
//  Copyright © 2017 Genesis. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var diseaseDictCache: [DiseaseDict] = []
    var filteredData: [DiseaseDict] = []
    var isSearching = false
    var index: Int = 0
  
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self;
        searchBar.isHidden = true;
        searchBar.isUserInteractionEnabled = false;
        self.navigationController?.navigationBar.isTranslucent = false;
        loadData()

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Making Detailed")
        index = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailedViewController = segue.destination as? DetailedViewController {
            if isSearching {
                detailedViewController.disease = filteredData[index]
            } else {
                detailedViewController.disease = diseaseDictCache[index]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return array.size
        if isSearching {
            return filteredData.count;
        }
        return diseaseDictCache.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath);
        if isSearching {
        cell.textLabel?.text = filteredData[indexPath.row].name;
        } else {
            cell.textLabel?.text = diseaseDictCache[indexPath.row].name;
        }
        return cell;
    }
    
    
    func loadData() {
        print("Trying to fetch Data")
        let customSerialQueue = DispatchQueue(label: "popularLoad")
        customSerialQueue.async {
            if let path = Bundle.main.path(forResource: "diseaseDict", ofType: "json") {
                print("Connected to file")
                let jsonResult = self.getJSON(path: path)
                
                print("Found Data")
                print(jsonResult)
                for result in jsonResult.arrayValue {
                    let name = result["name"].stringValue
                    let description = result["description"].stringValue
                    self.diseaseDictCache.append(DiseaseDict(name: name, description: description))
                    print("Recording Data")
                    print(self.diseaseDictCache)
                }
            }
            print("Reloading Tableview")
            self.diseaseDictCache.sort { $0.name < $1.name }

            DispatchQueue.main.async {
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
            filteredData = diseaseDictCache.filter({ $0.name.range(of: searchBar.text!, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil })
            tableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
