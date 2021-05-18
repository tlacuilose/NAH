//
//  GlosarioWatch.swift
//  [NAH]Watch WatchKit Extension
//
//  Created by Jose Tlacuilo on 18/05/21.
//

import Combine
import Foundation

class GlosarioWatch: ObservableObject {
    @Published var palabra: String = "NAH"
    @Published var espPalabra: String = "ESP"
    
    let glosarioURL = "http://martinmolina.com.mx/202111/equipo5/data/glosario.json"
    var palabras: [Palabra]?
    var palabrasIndex: Int = 0
    
    init() {
        if let url = URL(string: self.glosarioURL) {
            do {
                let data = try Data(contentsOf: url)
                self.palabras = try JSONDecoder().decode([Palabra].self, from: data)
                let random = Int.random(in: 0...(palabras!.count - 1))
                self.palabrasIndex =  random
            } catch {
                print("Glosario contents could not be loaded")
            }
        } else {
            print("The URL for glosario was bad.")
        }
        self.palabra = self.palabras?[palabrasIndex].nahuatl.uppercased() ?? "NAH"
        self.espPalabra = self.palabras?[palabrasIndex].español.uppercased() ?? "ESP"
    }
    
    func previous() {
        let newIndex = palabrasIndex - 1
        if let p = self.palabras, p.indices.contains(newIndex) {
            self.palabrasIndex = newIndex
            self.palabra = self.palabras?[palabrasIndex].nahuatl.uppercased() ?? "NAH"
            self.espPalabra = self.palabras?[palabrasIndex].español.uppercased() ?? "ESP"
        }
    }
    
    func next() {
        let newIndex = palabrasIndex + 1
        if let p = self.palabras, p.indices.contains(newIndex) {
            self.palabrasIndex = newIndex
            self.palabra = self.palabras?[palabrasIndex].nahuatl.uppercased() ?? "NAH"
            self.espPalabra = self.palabras?[palabrasIndex].español.uppercased() ?? "ESP"
        }
    }
}
