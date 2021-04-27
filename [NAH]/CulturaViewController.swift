//
//  CulturaViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 24/04/21.
//

import UIKit

class CulturaViewController: UIViewController {
    @IBOutlet weak var leccionesView: UIView!
    @IBOutlet weak var leccionesButton: UIButton!
    @IBOutlet weak var leccionesLeft: UIButton!
    @IBOutlet weak var leccionesRight: UIButton!
    @IBOutlet weak var leccionesLabel: UILabel!
    
    let jsonURL = "http://martinmolina.com.mx/202111/equipo5/data/leccionescultura.json"
    var lecciones: [LeccionCultura]?
    var leccionesIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: self.jsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.lecciones = try JSONDecoder().decode([LeccionCultura].self, from: data)
                self.leccionesLabel.text = lecciones![leccionesIndex].nombre
                self.leccionesLeft.isEnabled = false
                self.leccionesRight.isEnabled = self.lecciones!.indices.contains(self.leccionesIndex + 1)
            } catch {
                print("Lecciones cultura contents could not be loaded")
            }
        } else {
            print("The URL for lecciones cultura was bad.")
        }
    }
    
    @IBAction func moveLeccionesLeft(_ sender: Any) {
        self.previousLeccion()
        if let nombre = lecciones?[self.leccionesIndex].nombre {
            self.leccionesView.slideIn(.fromLeft)
            self.leccionesLabel.text = nombre
        } else {
            self.nextLeccion()
        }
    }
    
    @IBAction func moveLeccionesRight(_ sender: Any) {
        self.nextLeccion()
        if let nombre = lecciones?[self.leccionesIndex].nombre {
            self.leccionesView.slideIn(.fromRight)
            self.leccionesLabel.text = nombre
        } else {
            self.previousLeccion()
        }
    }
    
    func nextLeccion() {
        if let lecciones = self.lecciones, lecciones.indices.contains(self.leccionesIndex + 1) {
            self.leccionesIndex += 1
            self.leccionesLeft.isEnabled = true
            self.leccionesRight.isEnabled = lecciones.indices.contains(self.leccionesIndex + 1)
        }
    }
    
    func previousLeccion() {
        if let lecciones = self.lecciones, lecciones.indices.contains(self.leccionesIndex - 1) {
            self.leccionesIndex -= 1
            self.leccionesRight.isEnabled = true
            self.leccionesLeft.isEnabled = lecciones.indices.contains(self.leccionesIndex - 1)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "culturaLeccionSegue":
            if let leccion = self.lecciones?[self.leccionesIndex] {
                let detailView = segue.destination as! CulturaLeccionViewController
                detailView.leccion = leccion
            }
        case .none:
            let detailView = segue.destination as! CulturaLeccionViewController
            detailView.leccion = nil
        case .some(_):
            let detailView = segue.destination as! CulturaLeccionViewController
            detailView.leccion = nil
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
