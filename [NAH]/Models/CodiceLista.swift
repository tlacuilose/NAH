//
//  CodiceLista.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 30/04/21.
//

import Foundation

struct CodiceLista: Decodable {
    let id: Int
    let nombre: String
    let material: String
    let paginas: Int
    let ubicacion: String
    let link: String
}
