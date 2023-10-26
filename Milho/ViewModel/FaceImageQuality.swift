//
//  FaceImageQuality.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 23/10/23.
//

import SwiftUI
import Vision

class FaceImageQuality: ObservableObject {
    
    var inputImage: UIImage = UIImage()
    @Published var quality: Float?
    
    
    // Função responsável por analisar a qualidade da imagem.
    func faceQuality() {
        
        guard let image = inputImage.cgImage else { return }
        
        let faceDetectionRequest = VNDetectFaceCaptureQualityRequest(completionHandler: self.handleFaceQuality)
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        
        do {
            try requestHandler.perform([faceDetectionRequest])
        } catch {
            print("Error trying to perform face capture quality request: \(error.localizedDescription)")
        }
    }
    
    private func handleFaceQuality(request: VNRequest?, error: Error?) {
        if let requestError = error as NSError? {
            print(requestError.localizedDescription)
            return
        }
        
        if let results = request?.results as? [VNFaceObservation] {
            quality = results.first?.faceCaptureQuality
        }
    }
}
