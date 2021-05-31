//
//  GlosarioTableViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 26/03/21.
//

import UIKit
import Firebase

class GlosarioTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let jsonURL = "http://martinmolina.com.mx/202111/equipo5/data/glosario.json"
    var palabras: [Palabra]?
    var separatedPalabras: [[Palabra]]?
    var filteredData: [Palabra]?
    var sections: [String]?
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("glosarios").document("FPiPApIPo4ZaTuCGxhkO")
        

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                if let palabrasData = document.data()?["palabras"] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject:palabrasData)
                        print(data)
                        self.palabras = try JSONDecoder().decode([Palabra].self, from: data)
                        (self.sections , self.separatedPalabras) = self.findSections(in: self.palabras!)
                        
                        // Search flow
                        self.filteredData = self.palabras
            
                        
                        self.searchController.searchResultsUpdater = self
                        self.searchController.obscuresBackgroundDuringPresentation = false
                        self.searchController.hidesNavigationBarDuringPresentation = false
                        
                        self.tableView.tableHeaderView = self.searchController.searchBar
                        
                        self.tableView.register(UINib(nibName: "PalabraTableViewCell", bundle: nil), forCellReuseIdentifier: "palabraCell")
                        self.tableView.reloadData()
                    } catch {
                        print("Glosario contents could not be loaded")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        
        /*
        if let url = URL(string: self.jsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.palabras = try JSONDecoder().decode([Palabra].self, from: data)
                (self.sections , self.separatedPalabras) = findSections(in: self.palabras!)
                
                // Search flow
                self.filteredData = self.palabras
    
                
                searchController.searchResultsUpdater = self
                searchController.obscuresBackgroundDuringPresentation = false
                searchController.hidesNavigationBarDuringPresentation = false
                
                tableView.tableHeaderView = searchController.searchBar
                
                tableView.register(UINib(nibName: "PalabraTableViewCell", bundle: nil), forCellReuseIdentifier: "palabraCell")
                
                
                 // MARK: Subir documento a firebase
                /*
                let stringJson = try String(contentsOf: url)
                print(stringJson)
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:AnyObject]]
                
                print(jsonDict)
                
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("glosarios").addDocument(data: [
                    "palabras" : jsonDict!
                ]
                ) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                     */
                
            } catch {
                print("Glosario contents could not be loaded")
            }
        } else {
            print("The URL for glosario was bad.")
        }
 */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.separatedPalabras?[section].count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "palabraCell", for: indexPath) as! PalabraTableViewCell

        // Configure the cell...
        if let word = self.separatedPalabras?[indexPath.section][indexPath.row] {
            cell.fillContent(with: word)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections?[section] ?? ""
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.contentView.backgroundColor = UIColor(named: "AccentColor")
        header.textLabel?.textColor = .white
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UITableViewHeaderFooterView()
//        headerView.contentView.backgroundColor = UIColor(named: "AccentColor")
//        headerView.textLabel?.
//        return headerView
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Search updater
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text
        if searchTerm == "" {
            self.filteredData = self.palabras
        } else {
            self.filteredData = self.palabras?.filter({ (w) -> Bool in
                return w.nahuatl.lowercased().contains(searchTerm!.lowercased())
            })
        }
        (self.sections, self.separatedPalabras) = findSections(in: self.filteredData!)
        self.tableView.reloadData()
    }
    
    // MARK: Data manager
    
    func findSections(in words: [Palabra]) -> ([String], [[Palabra]]) {
        var uniques = Set<String>()
        var sections: [String] = []
        var palabras: [[Palabra]] = []
        words.forEach { (word) in
            if (!uniques.contains(word.atributo)) {
                sections.append(word.atributo)
                uniques.insert(word.atributo)
                palabras.append([word])
            } else {
                palabras[palabras.endIndex - 1].append(word)
            }
        }
        return  (sections, palabras)
    }
}
