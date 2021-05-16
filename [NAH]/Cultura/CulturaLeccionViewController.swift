//
//  CulturaLeccionViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 24/04/21.
//

import UIKit

class CulturaLeccionViewController: UIViewController {
    @IBOutlet weak var leccionText: UITextView!
    
    
    var leccion: LeccionCultura?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let htmlURLString = "http://martinmolina.com.mx/202111/equipo5/data/htmls/LeccionCultura\(self.leccion?.id ?? 1).html"
        if let htmlURL = URL(string: htmlURLString) {
            do {
                let data = try Data(contentsOf: htmlURL)
                if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
                    leccionText.attributedText = attributedString
                }
            } catch {
                print("HTML Leccion contents could not be loaded")
            }
        } else {
            print("The URL for leccion content html was bad.")
        }

        self.navigationItem.title = self.leccion?.nombre ?? "Leccion Cultura no encontrada"
        // Do any additional setup after loading the view.
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
