//
//  ColorAnalysisV2.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 08/11/23.
//

import SwiftUI
import Vision
import SimpleMatrixKit
import SwiftCluster

class ColorAnalysisV2: ObservableObject {
    
    var inputImage: UIImage = UIImage()
    
    @Published var eyeColorImage: UIImage?
    @Published var cheekColorImage: UIImage?
    
    @Published var eyeColors: [UIColor] = []
    @Published var cheekColors: [UIColor] = []
    
    func analysis() {
        
        segmentImage()
        eyeColorAnalysis()
        
    }
    
    private func eyeColorAnalysis() {
        guard let image = eyeColorImage else { return }
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        print(image.scale)
        
        var colorArray: [[Double]] = []
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
                
                colorArray.append([red, green, blue, alpha])
            }
        }
        
        
        print(colorArray.count)
        
        var redSum: Double = 0
        var greenSum: Double = 0
        var blueSum: Double = 0
        var alphaSum: Double = 0

        for i in 0..<colorArray.count {
            redSum += colorArray[i][0]
            greenSum += colorArray[i][1]
            blueSum += colorArray[i][2]
            alphaSum += colorArray[i][3]
        }

        let color = UIColor(red: redSum / Double(colorArray.count), green: greenSum / Double(colorArray.count), blue: blueSum / Double(colorArray.count), alpha: alphaSum / Double(colorArray.count))
        
        eyeColors.append(color)
        
        for i in 0..<colorArray.count {
            let color = UIColor(red: colorArray[i][0], green: colorArray[i][1], blue: colorArray[i][2], alpha: colorArray[i][3])
            
            eyeColors.append(color)
        }
        
        
//        let pixelColorData = Matrix(array2D: colorArray)
//        let clusterColorMatrix = performClusterAnalysis(pixelColorData)
//        
//        for i in 0..<3 {
//            let color = UIColor(red: clusterColorMatrix[i][0], green: clusterColorMatrix[i][1], blue: clusterColorMatrix[i][2], alpha: clusterColorMatrix[i][3])
//            eyeColors.append(color)
//        }
        
    }
    
    private func performClusterAnalysis(_ pixelColorData: Matrix<Double>) -> Matrix<Double> {
        let model = ClusterModel(
            data: pixelColorData,
            numberOfGroups: 3,
            initializationRule: .av,
            stoppingRules: [.distanceChange(percent: 0.001)],
            showDiagnostics: true
        )
        
        let (_, meanColors) = model.run()
        
        return meanColors
    }
    
    // Função responsável por utilizar a biblioteca Vision e segmentar a imagem.
    private func segmentImage() {
        
        guard let image = inputImage.cgImage else { return }
        let imageOrientation = CGImagePropertyOrientation(inputImage.imageOrientation)
        
        // Cria um request da biblioteca Vision.
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
    
    // Função que é chamada assim que o request termina.
    private func handleLandmarks(request: VNRequest?, error: Error?) {
        
        // Trata os erros.
        if let requestError = error as NSError? {
            print(requestError.localizedDescription)
            return
        }
        
        guard let observations = request?.results as? [VNFaceObservation] else { return }
        
        if observations.count != 1 {
            print("Quantidade de pessoas errada.")
            return
        }
        
        guard let observation = observations.first else { return }
        
        // 
        guard let leftEye = observation.landmarks?.leftEye else { return }
        guard let leftPupil = observation.landmarks?.leftPupil else { return }
        
        guard let rightEye = observation.landmarks?.rightEye else { return }
        guard let rightPupil = observation.landmarks?.rightPupil else { return }
        
        guard let points = observation.landmarks?.allPoints else { return }
        print(points.normalizedPoints.count)
        
        let normalizedPoints = points.pointsInImage(imageSize: inputImage.size)
        
        let leftEyeInImageCoordinate = leftEye.pointsInImage(imageSize: inputImage.size)
        let leftPupilInImageCoordinate = leftPupil.pointsInImage(imageSize: inputImage.size)
        
        let rightEyeInImageCoordinate = rightEye.pointsInImage(imageSize: inputImage.size)
        let rightPupilInImageCoorinate = rightPupil.pointsInImage(imageSize: inputImage.size)
        
        
        createPathForEyes(leftEye: leftEyeInImageCoordinate, leftPupilArray: leftPupilInImageCoordinate, rightEye: rightEyeInImageCoordinate, rightPupilArray: rightPupilInImageCoorinate, points: normalizedPoints)
        
        
    }
    
    private func createPathForEyes(leftEye: [CGPoint], leftPupilArray: [CGPoint], rightEye: [CGPoint], rightPupilArray: [CGPoint], points: [CGPoint]) {
        var normalizedLeftEye = leftEye
        var normalizedLeftPupil = leftPupilArray
        
        var normalizedRightEye = rightEye
        var normalizedRightPupil = rightPupilArray
        
        
        var normalizedPoints = points
        
        for i in 0..<normalizedLeftEye.count {
            normalizedLeftEye[i].y = (inputImage.size.height - normalizedLeftEye[i].y)
        }
        
        for i in 0..<normalizedRightEye.count {
            normalizedRightEye[i].y = (inputImage.size.height - normalizedRightEye[i].y)
        }
        
        for i in 0..<normalizedLeftPupil.count {
            normalizedLeftPupil[i].y = (inputImage.size.height - normalizedLeftPupil[i].y)
        }
        
        for i in 0..<normalizedRightPupil.count {
            normalizedRightPupil[i].y = (inputImage.size.height - normalizedRightPupil[i].y)
        }
        
        guard let leftPupil = normalizedLeftPupil.first else { return }
        guard let rightPupil = normalizedRightPupil.first else { return }
        
//        for i in 0..<normalizedPoints.count {
//            normalizedPoints[i].y = (inputImage.size.height - normalizedPoints[i].y)
//        }
//        
//        var path = Path()
//        
//        for i in 0..<normalizedPoints.count {
//            path.addArc(center: normalizedPoints[i], radius: 10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
//            path.closeSubpath()
//        }
        
        var leftEyeMaxY: CGFloat = 0
        var leftEyeMinY: CGFloat = 0
        
        for i in 0..<normalizedLeftEye.count {
            if i == 0 {
                leftEyeMaxY = normalizedLeftEye[i].y
                leftEyeMinY = normalizedLeftEye[i].y
            } else {
                if normalizedLeftEye[i].y > leftEyeMaxY {
                    leftEyeMaxY = normalizedLeftEye[i].y
                }
                
                if normalizedLeftEye[i].y < leftEyeMinY {
                    leftEyeMinY = normalizedLeftEye[i].y
                }
            }
        }
        
        var rightEyeMaxY: CGFloat = 0
        var rightEyeMinY: CGFloat = 0
        
        for i in 0..<normalizedRightEye.count {
            if i == 0 {
                rightEyeMaxY = normalizedRightEye[i].y
                rightEyeMinY = normalizedRightEye[i].y
            } else {
                if normalizedRightEye[i].y > rightEyeMaxY {
                    rightEyeMaxY = normalizedRightEye[i].y
                }
                
                if normalizedRightEye[i].y < rightEyeMinY {
                    rightEyeMinY = normalizedRightEye[i].y
                }
            }
        }
        
        
        let rightEyeRadius = rightEyeMaxY - rightEyeMinY
        let leftEyeRadius = leftEyeMaxY - leftEyeMinY
        
        var path = Path()
        
        // Iremos pegar 3 circulos pequenos em cada olho para analizar as cores neles.
        path.addArc(center: CGPoint(x: leftPupil.x, y: leftPupil.y + (leftEyeRadius * 0.38)), radius: leftEyeRadius * 0.10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: CGPoint(x: leftPupil.x + (leftEyeRadius * 0.38), y: leftPupil.y), radius: leftEyeRadius * 0.10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: CGPoint(x: leftPupil.x - (leftEyeRadius * 0.38), y: leftPupil.y), radius: leftEyeRadius * 0.10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: CGPoint(x: rightPupil.x, y: rightPupil.y + (rightEyeRadius * 0.38)), radius: rightEyeRadius * 0.10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: CGPoint(x: rightPupil.x + (rightEyeRadius * 0.38), y: rightPupil.y), radius: rightEyeRadius * 0.10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        path.addArc(center: CGPoint(x: rightPupil.x - (rightEyeRadius * 0.38), y: rightPupil.y), radius: rightEyeRadius * 0.10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
//        let leftEyeRadius = (leftEyeMaxY - leftEyeMinY) * 0.50
//        let rightEyeRadius = (rightEyeMaxY - rightEyeMinY) * 0.50
//        
//        var path = Path()
//        
//        path.addArc(center: normalizedLeftPupil.first ?? CGPoint.zero, radius: leftEyeRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
//        path.closeSubpath()
//        path.addArc(center: normalizedRightPupil.first ?? CGPoint.zero, radius: rightEyeRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
//        path.closeSubpath()
        
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
                
        eyeColorImage = render.uiImage
    }
}



