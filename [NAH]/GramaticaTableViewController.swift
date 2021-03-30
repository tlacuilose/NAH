//
//  GramaticaTableViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 16/03/21.
//

import UIKit

class GramaticaTableViewController: UITableViewController {
    
    let jsonURL = "http://martinmolina.com.mx/202111/equipo5/data/leccionesgramatica.json"
    var lecciones: [Leccion]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: self.jsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.lecciones = try JSONDecoder().decode([Leccion].self, from: data)
            } catch {
                print("Lecciones contents could not be loaded")
            }
        } else {
            print("The URL for lecciones was bad.")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.lecciones?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leccionTableCell", for: indexPath)

        if let nombreLeccion = self.lecciones?[indexPath.row].nombre {
            // Configure the cell...
            cell.textLabel?.text = nombreLeccion
        }
    
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let indexCell = self.tableView.indexPathForSelectedRow, let idLeccion = self.lecciones?[indexCell.row].id {
            let detailView = segue.destination as! LeccionViewController
            let detailTitle = "Detalle Leccion \(idLeccion)"
            detailView.titleLeccion = detailTitle
        }
    }
}
