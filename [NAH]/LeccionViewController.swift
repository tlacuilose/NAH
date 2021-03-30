//
//  LeccionViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 16/03/21.
//

import UIKit

class LeccionViewController: UIViewController {
    @IBOutlet weak var leccionAttributed: UILabel!
    
    @IBOutlet weak var vocabularioView: UIView!
    @IBOutlet weak var vocabularioTable: UITableView!
    
    @IBOutlet weak var gramaticaView: UIView!
    
    @IBOutlet weak var ejerciciosView: UIView!
    
    
    let jsonURL = "http://martinmolina.com.mx/202111/equipo5/data/vocaleccion.json"
    var vocabulario: [Palabra]?
    var leccion: Leccion?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // FIXME: HTML example for lections
        /*
        let html = """
        <!DOCTYPE html>
        <html>
          <body>
            <p>Paragraph</p>
            <li>
            <ul>
              <li>One</li>
              <li>Two</li>
            </ul>
          </body>
        </html>
        """
        let data = Data(html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
            leccionAttributed.attributedText = attributedString
        }
        */
        
        if let url = URL(string: self.jsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.vocabulario = try JSONDecoder().decode([Palabra].self, from: data)
            } catch {
                print("Glosario contents could not be loaded")
            }
        } else {
            print("The URL for glosario was bad.")
        }
        self.navigationItem.title = self.leccion?.nombre ?? "Leccion no encontrada"
        
        self.vocabularioTable.register(UINib(nibName: "PalabraTableViewCell", bundle: nil), forCellReuseIdentifier: "palabraCell")
        self.vocabularioTable.delegate = self
        self.vocabularioTable.dataSource = self
        
    }
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        let selection = sender.selectedSegmentIndex
        self.vocabularioView.isHidden = (selection != 0)
        self.gramaticaView.isHidden = (selection != 1)
        self.ejerciciosView.isHidden = (selection != 2)
    }
    
}
