//
//  LeccionViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 16/03/21.
//

import UIKit

class LeccionViewController: UIViewController {
    @IBOutlet weak var leccionAttributed: UILabel!
    
    var titleLeccion: String = "Leccion no disponible"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: HTML example for lections
        
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
        self.navigationItem.title = self.titleLeccion
        
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
