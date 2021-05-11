//
//  DiccUNAMViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 11/05/21.
//

import UIKit

class DiccUNAMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let exampleResponse = [["Paleografía": "ACATEHUITZATL", "Grafía normalizada": "acatehuitzatl", "Tipo": "r.n.", "Traducción uno": "Parties rugueuses de la plante caltôlin.", "Traducción dos": "parties rugueuses de la plante caltôlin.", "Diccionario ": "Wimmer", "Contexto": "âcatehuitzatl", "Fuente": "2004 Wimmer"], ["Paleografía": "acatevitzatl", "Grafía normalizada": "acatehuitzatl", "Tipo": "r.n.", "Traducción uno": "XI-194", "Traducción dos": "", "Diccionario ": "CF_INDEX", "Fuente": "1580 CF Index", "Notas": "v-- teui--"], ["Paleografía": "acatl", "Grafía normalizada": "acatl", "Tipo": "r.n.", "Traducción uno": "Caña ô Carrizo", "Traducción dos": "caña o carrizo", "Diccionario ": "Bnf_362", "Fuente": "17?? Bnf_362", "Notas": "Esp: ô--"]]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return self.exampleResponse.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diccUNAMCell", for: indexPath) as! DiccUNAMTableViewCell

        print(self.exampleResponse[indexPath.row])
        cell.paleo.text = self.exampleResponse[indexPath.row]["Paleografía"]
        cell.grafiaNorm.text = self.exampleResponse[indexPath.row]["Grafía normalizada"]
        cell.tipo.text = self.exampleResponse[indexPath.row]["Tipo"]
        cell.traduccionUno.text = self.exampleResponse[indexPath.row]["Traducción uno"]
        cell.traduccionDos.text = self.exampleResponse[indexPath.row]["Traducción dos"]
        cell.diccionario.text = self.exampleResponse[indexPath.row]["Diccionario"]
        cell.fuente.text = self.exampleResponse[indexPath.row]["Fuente"]
        cell.notas.text = self.exampleResponse[indexPath.row]["Notas"]
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
