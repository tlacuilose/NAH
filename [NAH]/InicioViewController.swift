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
    @IBOutlet weak var palabraRecomendadaLabel: UILabel!
    @IBOutlet weak var respuestaRecomendadaLabel: UILabel!
    
    let jsonURL = "http://martinmolina.com.mx/202111/equipo5/data/leccionesgramatica.json"
    var lecciones: [Leccion]?
    var leccionRecomendada: Leccion?
    
    let glosarioURL = "http://martinmolina.com.mx/202111/equipo5/data/glosario.json"
    var palabras: [Palabra]?
    var palabraRecomendada: Palabra?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: self.jsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.lecciones = try JSONDecoder().decode([Leccion].self, from: data)
                let random = Int.random(in: 0...(lecciones!.count - 1))
                self.leccionRecomendada = self.lecciones![random]
                self.recomendadaLabel.text = leccionRecomendada!.nombre
                self.recomendadaButton.isHidden = false
            } catch {
                print("Lecciones contents could not be loaded")
            }
        } else {
            print("The URL for lecciones was bad.")
        }
        
        if let url = URL(string: self.glosarioURL) {
            do {
                let data = try Data(contentsOf: url)
                self.palabras = try JSONDecoder().decode([Palabra].self, from: data)
                let random = Int.random(in: 0...(palabras!.count - 1))
                self.palabraRecomendada = self.palabras![random]
                self.palabraRecomendadaLabel.text = self.palabraRecomendada?.nahuatl
                self.respuestaRecomendadaLabel.text = self.palabraRecomendada?.español
            } catch {
                print("Glosario contents could not be loaded")
            }
        } else {
            print("The URL for glosario was bad.")
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "inicioLeccion" {
            if let leccion = leccionRecomendada {
                let detailView = segue.destination as! LeccionViewController
                detailView.leccion = leccion
            }
        }
    }
    
    // MARK: SM Buttons
    @IBAction func goFB(_ sender: Any) {
        if let url = NSURL(string: "https://www.facebook.com/Nahuatl.mx/") {

            UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)

        }
    }
    
    @IBAction func goTw(_ sender: Any) {
        if let url = NSURL(string: "https://twitter.com/tipsdenahuatl") {
        
        UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
            
        }
    }
    
    @IBAction func goIns(_ sender: Any) {
        if let url = NSURL(string: "https://www.instagram.com/aprendamos_nahuatl/?hl=es") {
        
        UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
            
        }
    }
    
    @IBAction func goWA(_ sender: Any) {
        let items = ["Aprende náhuatl en la app [NAH]. (url en app store)"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
