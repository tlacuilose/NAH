//
//  InicioViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 17/04/21.
//

import UIKit

class InicioViewController: UIViewController {
    @IBOutlet weak var recomendadaLabel: UILabel!
    @IBOutlet weak var recomendadaButton: UIButton!
    
    let jsonURL = "http://martinmolina.com.mx/202111/equipo5/data/leccionesgramatica.json"
    var lecciones: [Leccion]?
    var leccionRecomendada: Leccion?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: self.jsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.lecciones = try JSONDecoder().decode([Leccion].self, from: data)
                let random = Int.random(in: 0...lecciones!.count)
                self.leccionRecomendada = self.lecciones![random]
                self.recomendadaLabel.text = leccionRecomendada!.nombre
                self.recomendadaButton.isHidden = false
            } catch {
                print("Lecciones contents could not be loaded")
            }
        } else {
            print("The URL for lecciones was bad.")
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let leccion = leccionRecomendada {
            let detailView = segue.destination as! LeccionViewController
            detailView.leccion = leccion
        }
    }
    

}
