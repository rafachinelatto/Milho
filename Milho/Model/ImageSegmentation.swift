//
//  ImageSegmentation.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 23/10/23.
//

import SwiftUI
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageSegmentation: ObservableObject {
    
    var inputImage: UIImage = UIImage()
    @Published var outputImage: UIImage?
    
    
    // Função responsável por isolar a pessoa para futura análise.
    func segmentImage() {
        
        guard let image = inputImage.cgImage else { return }
        
        // Cria um request da biblioteca Vision.
        let request = VNGeneratePersonSegmentationRequest()
        request.revision = VNGeneratePersonSegmentationRequestRevision1
        request.qualityLevel = VNGeneratePersonSegmentationRequest.QualityLevel.accurate
        request.outputPixelFormat = kCVPixelFormatType_OneComponent8
        
        // Crio o request handler, que é utilizado para chamar o nosso request.
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        
        // Processa o request.
        do {
            try requestHandler.perform([request])
        } catch {
            print("Faild to perfom segmentation: \(error.localizedDescription)")
        }
    
        
        // Processa os resultados.
        guard let result = request.results, let mask = result.first else { return }
        
        removeBackgound(filterMask: mask.pixelBuffer)
    }
    
    private func removeBackgound(filterMask: CVPixelBuffer) {
        
        
        guard let image = inputImage.cgImage else { return }
        guard let bgImage = UIImage.imageFromColor(color: UIColor.clear, size: inputImage.size,  scale: inputImage.scale), let cgBgImage = bgImage.cgImage  else { return }

        
        let input = CIImage(cgImage: image)
        let mask = CIImage(cvImageBuffer: filterMask)
        let background = CIImage(cgImage: cgBgImage)
        
        let maskScaleX = input.extent.width / mask.extent.width
        let maskScaleY = input.extent.height / mask.extent.height
        let maskScaled = mask.transformed(by: __CGAffineTransformMake(maskScaleX, 0, 0, maskScaleY, 0, 0))
        
        let contex = CIContext()
        let blendFilter = CIFilter.blendWithRedMask()
        blendFilter.inputImage = input
        blendFilter.backgroundImage = background
        blendFilter.maskImage = maskScaled
        
        let blendedImage = blendFilter.outputImage
        
        if let finalImage = blendedImage, let cgOutputImage = contex.createCGImage(finalImage, from: input.extent) {
            outputImage = UIImage(cgImage: cgOutputImage)
        }
    }
    
    
}
