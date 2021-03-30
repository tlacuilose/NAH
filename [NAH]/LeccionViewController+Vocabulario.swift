//
//  LeccionViewController+Vocabulario.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 30/03/21.
//

import UIKit

extension LeccionViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Vocabulario Data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.leccion?.nombre
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vocabulario?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "palabraCell", for: indexPath) as! PalabraTableViewCell

        // Configure the cell...
        if let word = self.vocabulario?[indexPath.row] {
            cell.fillContent(with: word)
        }
        return cell
    }
}
