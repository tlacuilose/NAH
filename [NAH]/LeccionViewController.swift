//
//  LeccionViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 16/03/21.
//

import UIKit

class LeccionViewController: UIViewController {
    @IBOutlet weak var leccionTitle: UILabel!
    
    var titleLeccion: String = "Leccion no disponible"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leccionTitle.text = titleLeccion
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
