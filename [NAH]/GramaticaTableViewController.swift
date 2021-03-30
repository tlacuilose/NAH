//
//  GramaticaTableViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 16/03/21.
//

import UIKit

class GramaticaTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 30
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leccionTableCell", for: indexPath)

        
        // Configure the cell...
        cell.textLabel?.text = "Leccion \(indexPath.row)"
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let indexCell = self.tableView.indexPathForSelectedRow {
            let detailView = segue.destination as! LeccionViewController
            let detailTitle = "Detalle Leccion \(indexCell.row)"
            detailView.titleLeccion = detailTitle
        }
    }
}
