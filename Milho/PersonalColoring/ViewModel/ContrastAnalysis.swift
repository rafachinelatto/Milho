//
//  ContrastAnalysis.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 14/11/23.
//

import SwiftUI
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

class ContrastAnalysis: ObservableObject {
    
    var inputImage: UIImage = UIImage()
    var skinTone: UIColor = UIColor()
    
    @Published var grayScaleImage: UIImage?
    @Published var eyeColorImage: UIImage?
    @Published var eyeColor: UIColor?
    
    func analysis() {
        
        grayScale()
        getEyeContrast()
        getColor()
    }
    
    
    private func getColor() {
        guard let image = eyeColorImage else { return }
        
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
            
            eyeColor = color
        }
    }
    
    private func grayScale() {
        
        // Cria a CIImage a partir da inputImage (UIImage).
        guard let beginImage = CIImage(image: inputImage) else { return }
        
        
        let contex = CIContext()
        let filter = CIFilter.colorControls()
        filter.inputImage = beginImage
        filter.saturation = 0.0
        filter.brightness = 0.0
        filter.contrast = 1.1
        
        guard let outputImage = filter.outputImage else { return }
        guard let cgOutputImage = contex.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        grayScaleImage = UIImage(cgImage: cgOutputImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
    }
    
    
    private func getEyeContrast() {
        guard let grayImage = grayScaleImage else { return }
        guard let image = grayImage.cgImage else { return }
        let imageOrientation = CGImagePropertyOrientation(inputImage.imageOrientation)
        
        // Cria um request da biblioteca Vision
        let request = VNDetectFaceLandmarksRequest(completionHandler: self.handleLandmarks)
        
        // Cria o request handler, que é responsável por executar nosso request.
        let requestHandler = VNImageRequestHandler(cgImage: image, orientation: imageOrientation, options: [:])
        
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
    
    private func handleLandmarks(request: VNRequest?, error: Error?) {
        
        // Trata os erros.
        if let requestError = error as NSError? {
            print(requestError.localizedDescription)
            
            // Possivel lógica para trocar a imagem que foi colocada no inputImage.
            
            return
        }
        
        
        guard let observations = request?.results as? [VNFaceObservation] else { return }
        guard let observation = observations.first else { return }
        
        guard let leftEye = observation.landmarks?.leftEye?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let leftPupil = observation.landmarks?.leftPupil?.pointsInImage(imageSize: inputImage.size) else { return }
        
        guard let rightEye = observation.landmarks?.rightEye?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let rightPupil = observation.landmarks?.rightPupil?.pointsInImage(imageSize: inputImage.size) else { return }
        
        guard let leftPupilPoint = leftPupil.first else { return }
        guard let rightPupilPoint = rightPupil.first else { return }
        
        var leftIrisPoints: [CGPoint] = []
        var rightIrisPoints: [CGPoint] = []
        
        var leftEyeMinY = 0.0
        var leftEyeMaxY = 0.0
        var rightEyeMinY = 0.0
        var rightEyeMaxY = 0.0
        
        for i in 0..<leftEye.count {
            if i == 0 {
                leftEyeMaxY = leftEye[i].y
                leftEyeMinY = leftEye[i].y
            } else {
                if leftEyeMaxY < leftEye[i].y {
                    leftEyeMaxY = leftEye[i].y
                }
                
                if leftEyeMinY > leftEye[i].y {
                    leftEyeMinY = leftEye[i].y
                }
            }
        }

        for i in 0..<rightEye.count {
            if i == 0 {
                rightEyeMaxY = leftEye[i].y
                rightEyeMinY = leftEye[i].y
            } else {
                if rightEyeMaxY < rightEye[i].y {
                    rightEyeMaxY = rightEye[i].y
                }
                
                if rightEyeMinY > rightEye[i].y {
                    rightEyeMinY = rightEye[i].y
                }
            }
        }
        
        let leftIrisRadius = (leftEyeMaxY - leftEyeMinY) * 0.9
        let rightIrisRadius = (rightEyeMaxY - rightEyeMinY) * 0.9
        
        leftIrisPoints.append(CGPoint(x: leftPupilPoint.x + leftIrisRadius * 0.4, y: leftPupilPoint.y))
        leftIrisPoints.append(CGPoint(x: leftPupilPoint.x - leftIrisRadius * 0.4, y: leftPupilPoint.y))
        leftIrisPoints.append(CGPoint(x: leftPupilPoint.x, y: leftPupilPoint.y - leftIrisRadius * 0.4))
        
        rightIrisPoints.append(CGPoint(x: rightPupilPoint.x + rightIrisRadius * 0.4, y: rightPupilPoint.y))
        rightIrisPoints.append(CGPoint(x: rightPupilPoint.x - rightIrisRadius * 0.4, y: rightPupilPoint.y))
        rightIrisPoints.append(CGPoint(x: rightPupilPoint.x, y: rightPupilPoint.y - rightIrisRadius * 0.4))
        
        let leftRadius = leftIrisRadius * 0.05
        let rightRadius = rightIrisRadius * 0.05
        
        createImageMask(leftIrisPoints: leftIrisPoints, leftRadius: leftRadius, rightIrisPoints: rightIrisPoints, rightRadius: rightRadius)
    }
    
    
    private func createImageMask(leftIrisPoints: [CGPoint], leftRadius: CGFloat, rightIrisPoints: [CGPoint], rightRadius: CGFloat) {
        
        var leftIris: [CGPoint] = []
        var rightIris: [CGPoint] = []
        
        for i in 0..<leftIrisPoints.count {
            let point = CGPoint(x: leftIrisPoints[i].x, y: (inputImage.size.height - leftIrisPoints[i].y))
            leftIris.append(point)
        }
        
        for i in 0..<rightIrisPoints.count {
            let point = CGPoint(x: rightIrisPoints[i].x, y: (inputImage.size.height - rightIrisPoints[i].y))
            rightIris.append(point)
        }
        
        var path = Path()
        
        for i in 0..<leftIris.count {
            
            path.addArc(center: leftIris[i], radius: leftRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
            path.closeSubpath()
            path.addArc(center: rightIris[i], radius: rightRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
            path.closeSubpath()
        }
        
        DispatchQueue.main.async {
            self.renderImage(path: path)
        }
    }
    
    @MainActor private func renderImage(path: Path) {
        let render = ImageRenderer(content:
                                     
            Image(uiImage: grayScaleImage ?? inputImage)
                .frame(width: inputImage.size.width, height: inputImage.size.height)
                .mask(alignment: .center, {
                    FaceContourShape(facePath: path)
                }))
        
        eyeColorImage = render.uiImage
    }
    
}
