//
//  SkinToneAnalysis.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 13/11/23.
//

import SwiftUI
import Vision

class SkinToneAnalysis: ObservableObject {
    
    var inputImage: UIImage = UIImage()
    
    @Published var outputImage: UIImage?
    @Published var skinTone: UIColor?
    
    func analysis() {
        
        getPoints()
        getColor()
        
    }
    
    
    private func getColor() {
        guard let image = outputImage else { return }
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var redSum: Double = 0
        var greenSum: Double = 0
        var blueSum: Double = 0
        var alphaSum: Double = 0
        var count: Double = 0

        for x in 0..<pixelWidth {
            for y in 0..<pixelHeight {
                
                let scaledX = CGFloat(x) * image.scale
                let scaledY = CGFloat(y) * image.scale
                
                let point = CGPoint(x: scaledX, y: scaledY)
                let pixelInfo: Int = ((pixelWidth * Int(point.y)) + Int(point.x)) * 4
                
                let red = Double(data[pixelInfo]) / 255.0
                let green = Double(data[pixelInfo + 1]) / 255.0
                let blue = Double(data[pixelInfo + 2]) / 255.0
                let alpha = Double(data[pixelInfo + 3]) / 255.0
                
                guard (red != 0) || (green != 0) || (blue != 0) else { continue }
                
                redSum += red
                greenSum += green
                blueSum += blue
                alphaSum += alpha
                count += 1
            }
        }

        if count > 0 {
            let color = UIColor(red: redSum / Double(count), green: greenSum / Double(count), blue: blueSum / Double(count), alpha: alphaSum / Double(count))
            
            skinTone = color
        }
    }
    
    
    
    private func getPoints() {
        
        guard let image = inputImage.cgImage else { return }
        let imageOrientation = CGImagePropertyOrientation(inputImage.imageOrientation)
        
        // Cria um request da biblioteca Vision.
        let request = VNDetectFaceLandmarksRequest(completionHandler: self.handleLandmarks)
        
        // Cria o request handler para poder executar nosso request.
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: imageOrientation ,options: [:])
        
        // Executa de forma assíncrona o request.
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch let error as NSError {
                
                // Implementar lógica para escolher outra imagem caso necessário.
                
                print(error.localizedDescription)
                return
            }
        }
    }
    
    private func handleLandmarks(request: VNRequest?, error: Error?) {
        
        // Trata os erros.
        if let requestError = error as NSError? {
            print(requestError.localizedDescription)
            
            // Implemetar lógica para escolher outra imagem caso necessário.
            
            return
        }
        
        guard let observations = request?.results as? [VNFaceObservation] else { return }
        
        guard let observation = observations.first else { return }
        
        guard let faceContour = observation.landmarks?.faceContour?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let outerLips = observation.landmarks?.outerLips?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let nose = observation.landmarks?.nose?.pointsInImage(imageSize: inputImage.size) else { return }
        
        let boundingBox = observation.boundingBox
        
        
        guard let faceContourMinX = faceContour.last else { return }
        guard let faceContourMaxX = faceContour.first else { return }
        
        var outerLipsMinX: CGPoint = CGPoint.zero
        var outerLipsMaxX: CGPoint = CGPoint.zero
        for i in 0..<outerLips.count {
            if i == 0 {
                outerLipsMaxX = outerLips[i]
                outerLipsMinX = outerLips[i]
            } else {
                if outerLipsMinX.x > outerLips[i].x {
                    outerLipsMinX = outerLips[i]
                }
                if outerLipsMaxX.x < outerLips[i].x {
                    outerLipsMaxX = outerLips[i]
                }
            }
        }
        
        
        let leftCheek = CGPoint(x: ((outerLipsMinX.x + faceContourMinX.x) / 2) , y: ((outerLipsMinX.y + faceContourMinX.y) / 2))
        
        let leftCheekRadius = sqrt((pow((outerLipsMinX.x - faceContourMinX.x), 2)) + pow((outerLipsMinX.y - faceContourMinX.y), 2)) * 0.15
        
        let rightCheek = CGPoint(x: ((outerLipsMaxX.x + faceContourMaxX.x) / 2) , y: ((outerLipsMaxX.y + faceContourMaxX.y) / 2))
        
        let rightCheekRadius = sqrt((pow((outerLipsMaxX.x - faceContourMaxX.x), 2)) + pow((outerLipsMaxX.y - faceContourMaxX.y), 2)) * 0.15
        
        
        var noseMax = CGPoint.zero
        var noseMin = CGPoint.zero
        
        for i in 0..<nose.count {
            if i == 0 {
                noseMax = nose[i]
                noseMin = nose[i]
            } else {
                if noseMax.y < nose[i].y {
                    noseMax = nose[i]
                }
                if noseMin.y > nose[i].y {
                    noseMin = nose[i]
                }
            }
        }
        
        let nosePoint = CGPoint(x: ((noseMax.x + noseMin.x) / 2), y: ((noseMax.y + noseMin.y) / 2))
        
        let noseRadius = sqrt((pow(noseMax.x - noseMin.x, 2)) + (pow(noseMax.y - noseMin.y, 2))) * 0.15

        let forehead = CGPoint(x: ((boundingBox.minX + boundingBox.maxX) / 2) * inputImage.size.width, y: boundingBox.maxY * inputImage.size.height)
        let foreheadRadius = boundingBox.width * inputImage.size.width * 0.07
        
        createImageMask(leftCheek: leftCheek, leftCheekRadius: leftCheekRadius, rightCheek: rightCheek, rightCheekRadius: rightCheekRadius, nose: nosePoint, noseRadius: noseRadius, forehead: forehead, foreheadRadius: foreheadRadius)
        
    }
    
    private func createImageMask(leftCheek: CGPoint, leftCheekRadius: CGFloat, rightCheek: CGPoint, rightCheekRadius: CGFloat, nose: CGPoint, noseRadius: CGFloat, forehead: CGPoint, foreheadRadius: CGFloat) {
        
        let leftCheekPoint = CGPoint(x: leftCheek.x, y: (inputImage.size.height - leftCheek.y))
        let rightCheekPoint = CGPoint(x: rightCheek.x, y: (inputImage.size.height - rightCheek.y))
        let nosePoint = CGPoint(x: nose.x, y: (inputImage.size.height) - nose.y)
        let foreheadPoint = CGPoint(x: forehead.x, y: (inputImage.size.height) - forehead.y)
        
        var path = Path()
        
        path.addArc(center: leftCheekPoint, radius: leftCheekRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: rightCheekPoint, radius: rightCheekRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: nosePoint, radius: noseRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: foreheadPoint, radius: foreheadRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        
        DispatchQueue.main.async {
            self.renderImage(path: path)
        }
    }
    
    @MainActor private func renderImage(path: Path) {
        let render = ImageRenderer(content:
            Image(uiImage: inputImage)
                .frame(width: inputImage.size.width, height: inputImage.size.height)
                .mask(alignment: .center, {
                    FaceContourShape(facePath: path)
                }))
        
        outputImage = render.uiImage
    }
}
