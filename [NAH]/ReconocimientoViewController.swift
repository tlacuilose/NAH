//
//  ReconocimientoViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 17/04/21.
//

import UIKit
import CoreML
import Vision

class ReconocimientoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    let translations = [
    "Apple Braeburn": "mantsanatl",
    "Apricot": "chauakatl",
    "Avocado": "auakatli",
    "Banana": "tsapalotl",
    "Blueberry": "texokapolin",
    "Cantaloupe 2": "ayotetl",
    "Cherry 1": "kapolin",
    "Clementine": "otonlalaxtli",
    "Cocos": "kokotl",
    "Corn": "elotl",
    "Cucumber Ripe": "ayoxoxoukatl",
    "Grape Blue": "xokomekatl",
    "Grape White 4": "ueylalaxtli",
    "Grapefruit Pink": "ueyxokotl",
    "Grapefruit White": "ueyxokotl",
    "Guava": "chalxokotl",
    "Kiwi": "kiwitl",
    "Lemon": "xoxokotl",
    "Limes": "limaxokotl",
    "Mandarine": "tentsonxokotl",
    "Mango": "manilatsapotl",
    "Orange": "ueylalaxtli",
    "Papaya": "ochonetli",
    "Strawberry": "asexokotl",
    "Tomato 4": "xaltomatl",
    "Watermelon": "ueleyatl",
    ]

    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            self.cameraButton.isHidden = true
        }
        self.imagePicker.delegate = self
    }
    
    @IBAction func openCamera(_ sender: Any) {
        self.imagePicker.sourceType = .camera
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: ImagePicker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    @IBAction func ejecutarML() {
        //instanciar el modelo de la red neuronal
        let modelFile = FruitClassifier1()
        let model = try! VNCoreMLModel(for: modelFile.model)
        //Convertir la imagen obtenida a CIImage
        let imagenCI = CIImage(image: imageView.image!)
        //Crear un controlador para el manejo de la imagen, este es un requerimiento para ejecutar la solicitud del modelo
        let handler = VNImageRequestHandler(ciImage: imagenCI!)
        //Crear una solicitud al modelo para el análisis de la imagen
        let request = VNCoreMLRequest(model: model, completionHandler: resultadosModelo)
        try! handler.perform([request])
        
    }
    
    func resultadosModelo(request: VNRequest, error: Error?)
    {
        guard let results = request.results as? [VNClassificationObservation] else { fatalError("No hubo respuesta del modelo ML")}
        var bestPrediction = ""
        var bestConfidence: VNConfidence = 0
        //recorrer todas las respuestas en búsqueda del mejor resultado
        for classification in results{
            if (classification.confidence > bestConfidence){
                bestConfidence = classification.confidence
                bestPrediction = classification.identifier
            }
        }
        let resultado = bestPrediction+" "+String(bestConfidence)
        print(resultado)
        print(translations[bestPrediction] ?? "No es fruta.")
        predictionLabel.text = translations[bestPrediction] ?? "No es fruta."
    }}
