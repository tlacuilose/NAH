//
//  LeccionViewController+Ejercicios.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 30/04/21.
//

import Foundation

extension LeccionViewController {
    
    func loadEjercicios() {
        if let url = URL(string: self.ejJsonURL) {
            do {
                let data = try Data(contentsOf: url)
                self.ejercicios = try JSONDecoder().decode([Ejercicio].self, from: data)
                self.ejercicios = self.ejercicios?.filter({ e in
                    return e.leccion == self.leccion?.id
                })
                displayEjercicio(ejercicios![ejerciciosIndex])
                self.ejRespuestaLabel.isHidden = true
                self.ejerciciosLeft.isEnabled = false
                self.ejerciciosRight.isEnabled = self.ejercicios!.indices.contains(self.ejerciciosIndex + 1)
            } catch {
                print("Ejercicios cultura contents could not be loaded")
            }
        } else {
            print("The URL for ejercicios cultura was bad.")
        }
    }
    
    func displayEjercicio(_ e: Ejercicio) {
        switch e.tipo {
        case "NAH-ESP":
            self.ejTipoLabel.text = "Traducir al español"
        case "ESP-NAH":
            self.ejTipoLabel.text = "Traducir al náhuatl"
        case "CON-NAH":
            self.ejTipoLabel.text = "Responde en náhuatl"
        case "PRO-NAH":
            self.ejTipoLabel.text = "Pronuncia en náhuatl"
        default:
            self.ejTipoLabel.text = "Ejercicio"
        }
        self.ejPreguntaLabel.text = e.pregunta
        self.ejRespuestaLabel.text = e.respuesta
    }
    
    func nextEjercicio() {
        if let ejercicios = self.ejercicios, ejercicios.indices.contains(self.ejerciciosIndex + 1) {
            self.ejerciciosIndex += 1
            self.ejerciciosLeft.isEnabled = true
            self.ejerciciosRight.isEnabled = ejercicios.indices.contains(self.ejerciciosIndex + 1)
        }
    }
    
    func previousEjercicio() {
        if let ejercicios = self.ejercicios, ejercicios.indices.contains(self.ejerciciosIndex - 1) {
            self.ejerciciosIndex -= 1
            self.ejerciciosRight.isEnabled = true
            self.ejerciciosLeft.isEnabled = ejercicios.indices.contains(self.ejerciciosIndex - 1)
        }
    }
}
