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
        
        let html = """
        <!doctype html>
        <html>
            <style>
            body {
            font-family: Helvetica;
            font-size: 18px;
            color: #5A4522;
            text-align: justify;
            text-padding: 20px;
            }
            </style>
          <body>
              <h3>¿Por qué náhuatl clásico y no una variante en específico?</h3>
            <p>Estudiar náhuatl clásico es  una buena aproximación al náhuatl hablado en las diversas regiones, además, este permite fijar de primera mano una estructura gramatical clara, la cual posteriormente aplicar los respectivos cambios de una variante ya no resultaría tan complicado que si lo realizaremos de forma contraria. </p>
            
            <p>Algunos cambios:</p>
            <p>En la zona de Milpa Alta, en la Ciudad de México se suele cambiar la i por la e y la u por la o, en lugar de “mi nombre” (notoka) dicen (notuka), en “gracias” (tlazohkamati) dicen (tlazohkamate).</p>

            <p>En ocasiones se pierden sonidos como por ejemplo:</p>
            <ol>
              <li>citlalin à citlali</li>
              <li>tepetl à tepe</li>
            </ol>

            <p>En ocasiones se pueden agregar sonidos</p>
            <ol>
              <li>pía à piya</li>
              <li>yei à yeyi</li>
              <li>ihtoa à ihtohua</li>
              <li>panoa à panohua</li>
            </ol>

            <p>Incluso puede haber cambios de sonidos por otros:</p>
            <ol>
              <li>ompa à umpa</li>
              <li>kename à kenemi</li>
              <li>atl à at</li>
              <li>chicome à chigome</li>
              <li>ihuan à ivan</li>
              <li>tochtli à toxtli</li>
              <li>xochitl à sochitl</li>
            </ol>

            <p>Ejemplo: Diferentes formas de decir escuela</p>
            <ol>
              <li>temachticalli</li>
              <li>caltemachtilli</li>
              <li>temachtiloyan</li>
              <li>calmachtiloyan</li>
              <li>nemachtiloyan</li>
              <li>tlamachtilcalco</li>
              <li>tlamachtilcalli</li>
            </ol>

            <p>Es importante no perderse en esto, pues si bien existen unos cambios, aprendiendo en náhuatl clásico realizar los cambios pertinentes dependiendo la región de la variante, no resultará complicado.</p>

          </body>
        </html>
        """
        let data = Data(html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
            leccionAttributed.attributedText = attributedString
        }
        
        
        
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
