//
//  DiccUNAMViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 11/05/21.
//

import UIKit

class DiccUNAMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var queryResponse: [[String : String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DictApi.getTranslations(query: "atl") { entries in
            print("DictApi.GetTranslations .......................................")
            self.queryResponse = entries
            self.tableView.reloadData()
        }

        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "DiccUNAMTableViewCell", bundle: nil), forCellReuseIdentifier: "diccUNAMCell")
        
        
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

        cell.paleo.text = self.queryResponse[indexPath.row]["Paleografía"]
        cell.grafiaNorm.text = self.queryResponse[indexPath.row]["Grafía normalizada"]
        cell.tipo.text = self.queryResponse[indexPath.row]["Tipo"]
        cell.traduccionUno.text = self.queryResponse[indexPath.row]["Traducción uno"]
        cell.traduccionDos.text = self.queryResponse[indexPath.row]["Traducción dos"]
        cell.diccionario.text = self.queryResponse[indexPath.row]["Diccionario"]
        cell.fuente.text = self.queryResponse[indexPath.row]["Fuente"]
        cell.notas.text = self.queryResponse[indexPath.row]["Notas"]
        
        
        return cell
    }

}
