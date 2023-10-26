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
    
    var secondPartInputImage: UIImage = UIImage()
    @Published var outputImage: UIImage?
    @Published var quality: Float?
    
    var faceContourPath: Path?
    
    // Função resposnsável pela segmentação da imagem.
    func segmentImage() {
        
        guard let image = inputImage.cgImage else { return }
        
        // Criar um request do Vision
        let request = VNGeneratePersonSegmentationRequest()
        request.revision = VNGeneratePersonSegmentationRequestRevision1
        request.qualityLevel = VNGeneratePersonSegmentationRequest.QualityLevel.accurate
        request.outputPixelFormat = kCVPixelFormatType_OneComponent8
        
        // Criar o request handler
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        
        // Processa o request de forma assíncrona
     
        do {
            try requestHandler.perform([request])
        } catch {
            print("Faild to perfom segmentation: \(error.localizedDescription)")
        }
    
        
        // Processa os resultados
        guard let result = request.results, let mask = result.first else { return }
        
        removeBackgound(filterMask: mask.pixelBuffer)
    }
    
    
    private func removeBackgound(filterMask: CVPixelBuffer) {
        
        
        guard let image = inputImage.cgImage else { return }
        guard let bgImage = UIImage.imageFromColor(color: .black, size: inputImage.size,  scale: inputImage.scale), let cgBgImage = bgImage.cgImage  else { return }

        
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
    
            self.secondPartInputImage = UIImage(cgImage: cgOutputImage)
            
            faceContour()
        }
    }
    
    private func faceContour() {

        guard let image = secondPartInputImage.cgImage else { return }
        
        // Cria um request da biblioteca Vision
        let request = VNDetectFaceLandmarksRequest(completionHandler: self.handleFaceContour)
        
        // Cria o request handler que é responsável por executar o request.
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        
        // Executa de forma assíncrona.
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch let error as NSError {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    private func handleFaceContour(request: VNRequest?, error: Error?) {
        if let requestError = error as NSError? {
            print(requestError.localizedDescription)
            return
        }
        
        
        guard let observations = request?.results as? [VNFaceObservation] else { return }
        guard let observation = observations.first else { return }
        guard let face = observation.landmarks?.faceContour else { return }
        
        
        
        let faceContourPointsInImageCoordinate = face.pointsInImage(imageSize: inputImage.size)
        
        createPathFromImageCoordinates(points: faceContourPointsInImageCoordinate)
    }
    
    
    private func createPathFromImageCoordinates(points: [CGPoint]) {
        
        var normalizedPoints = points
        
        for i in 0..<normalizedPoints.count {
            normalizedPoints[i].y = ((inputImage.size.height - normalizedPoints[i].y))
        }
        
        var facePath = Path()
        
        facePath.addLines(normalizedPoints)
        facePath.move(to: normalizedPoints.last ?? CGPoint.zero)
        facePath.addLine(to: CGPoint(x: 0, y: normalizedPoints.last?.y ?? 0))
        facePath.addLine(to: CGPoint(x: 0, y: 0))
        facePath.addLine(to: CGPoint(x: inputImage.size.width, y: 0))
        facePath.addLine(to: CGPoint(x: inputImage.size.width, y: normalizedPoints.first?.y ?? 0))
        facePath.addLine(to: normalizedPoints.first ?? CGPoint.zero)
        facePath.closeSubpath()
        
        faceContourPath = facePath
        
        DispatchQueue.main.async {
            self.renderImage()
        }
    }
    
    
    @MainActor private func renderImage() {
        guard let facePath = faceContourPath else { return }
        
        let renderer = ImageRenderer(content: Image(uiImage: secondPartInputImage)
            .frame(width: inputImage.size.width, height: inputImage.size.height)
            .mask(alignment: .center) {
                FaceContourShape(facePath: facePath)
            })
        outputImage = renderer.uiImage
    }
    
    
    func faceQuality() {
        guard let image = inputImage.cgImage else { return }
        
        let faceDetectionRequest = VNDetectFaceCaptureQualityRequest(completionHandler: self.handleFaceQuality)
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
        
        
        do {
            try requestHandler.perform([faceDetectionRequest])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func handleFaceQuality(request: VNRequest?, error: Error?) {
        if let error = error as NSError? {
            print(error.localizedDescription)
            return
        }
        
        if let results = request?.results as? [VNFaceObservation] {
            quality = results.first?.faceCaptureQuality
            print(results.first?.faceCaptureQuality ?? 0)
        }
    }
}


struct FaceContourShape: Shape {
    
    var facePath: Path
    
    func path(in rect: CGRect) -> Path {
        return self.facePath
    }
    
}
