//
//  DiccUNAMViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 11/05/21.
//

import UIKit

class DiccUNAMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isEsp: Bool = false
    
    var queryResponse: [[String : String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "DiccUNAMTableViewCell", bundle: nil), forCellReuseIdentifier: "diccUNAMCell")
        
        self.searchBar.delegate = self
        
        
    }
    
    
    @IBAction func changeLang(_ sender: UISegmentedControl) {
        self.isEsp = sender.selectedSegmentIndex != 0 ? true : false
        self.searchBar.placeholder = sender.selectedSegmentIndex != 0 ? "Busca en español" : "Busca en náhuatl"
    }
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.queryResponse.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diccUNAMCell", for: indexPath) as! DiccUNAMTableViewCell

        cell.paleo.text = self.queryResponse[indexPath.row]["Paleografía"]?.lowercased()
        cell.grafiaNorm.text = self.queryResponse[indexPath.row]["Grafía normalizada"]
        cell.tipo.text = self.queryResponse[indexPath.row]["Tipo"]
        cell.traduccionDos.text = self.queryResponse[indexPath.row]["Traducción dos"]
        cell.fuente.text = self.queryResponse[indexPath.row]["Fuente"]
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.white : UIColor.systemGroupedBackground
        
        
        return cell
    }
    
    // MARK: SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            DictApi.getTranslations(query: searchText, get2es: self.isEsp) { entries in
                self.queryResponse = entries
                self.tableView.reloadData()
                self.searchBar.resignFirstResponder()
            }
            // Should also include errorHandler.
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }

}
