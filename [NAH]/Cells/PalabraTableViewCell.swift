//
//  PalabraTableViewCell.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 27/03/21.
//

import UIKit

class PalabraTableViewCell: UITableViewCell {
    @IBOutlet weak var nahuatlLabel: UILabel!
    @IBOutlet weak var espanolLabel: UILabel!
    @IBOutlet weak var verButton: UIButton!
    
    var showsTranslation = false

    private var palabra: Palabra?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.espanolLabel.isHidden = true
        showsTranslation = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
        
    }
    
    @IBAction func verTraduccion(_ sender: Any) {
        showsTranslation.toggle()
        espanolLabel.isHidden = !self.showsTranslation
        self.verButton.setTitle(self.showsTranslation ? "Ocultar" : "Mostrar", for: .normal)
    }
    
    func fillContent(with palabra: Palabra) {
        self.palabra = palabra
        self.nahuatlLabel.text = palabra.nahuatl
        self.espanolLabel.text = palabra.español
        self.showsTranslation = false
        self.espanolLabel.isHidden = true
    }
}
