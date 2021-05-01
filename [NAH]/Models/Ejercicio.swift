//
//  Ejercicio.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 30/04/21.
//

import Foundation

struct Ejercicio: Decodable {
    let id: Int
    let leccion: Int
    let tipo: String
    let pregunta: String
    let respuesta: String
}
