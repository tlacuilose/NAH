//
//  DiccUNAMTableViewCell.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 11/05/21.
//

import UIKit

class DiccUNAMTableViewCell: UITableViewCell {
    @IBOutlet weak var paleo: UILabel!
    @IBOutlet weak var grafiaNorm: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var traduccionUno: UILabel!
    @IBOutlet weak var traduccionDos: UILabel!
    @IBOutlet weak var diccionario: UILabel!
    @IBOutlet weak var fuente: UILabel!
    @IBOutlet weak var notas: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
