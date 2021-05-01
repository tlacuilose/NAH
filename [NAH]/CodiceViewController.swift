//
//  CodiceViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 30/04/21.
//

import UIKit
import WebKit

class CodiceViewController: UIViewController {
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var paginasLabel: UILabel!
    @IBOutlet weak var ubicacionLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var codice: Codice?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.codice?.nombre ?? "Codice no encontrado"
        
        if let codice = self.codice {
            self.nombreLabel.text = "\t\(codice.nombre)"
            self.paginasLabel.text = "\tPáginas: \(codice.paginas)"
            self.ubicacionLabel.text = "\tUbicación: \(codice.ubicacion)"
            self.materialLabel.text = "\tMaterial: \(codice.material)"
            
            if let url = URL(string: codice.link) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }

        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
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
