//
//  ColorAnalysis.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 16/11/23.
//

import SwiftUI
import Vision

class ColorAnalysis: ObservableObject {
    var inputImage: UIImage = UIImage()
    
    @Published var skinTone: UIColor?
    @Published var contrast: Int?   // Informação do contraste da pele: 0 -> baixo, 1 -> médio, 2 -> alto.
    
    var skinToneImage: UIImage?
    var grayScaleImage: UIImage?
    var eyeColorImage: UIImage?
    var hairColorImage: UIImage?
    @Published var eyebrowColorImage: UIImage?
    var eyeColor: UIColor?
    var hairColor: UIColor?
    var eyebrowColor: UIColor?
    
    func analysis() {
        getPoints()
        getSkinColor()
        grayScale()
        getEyeColor()
        getHairColor()
        getEyebrowColor()
        getContrastRate()
    }
    
    private func getContrastRate() {
        let ciSkinToneColor = CIColor(color: skinTone ?? .clear)
        let red = ciSkinToneColor.red
        let green = ciSkinToneColor.green
        let blue = ciSkinToneColor.blue
        
        let skinToneGrayScale: CGFloat = 10 - 10*(0.299*red + 0.587*green + 0.114*blue)
        
        let ciEyeColor = CIColor(color: eyeColor ?? .clear)
        let ciHairColor = CIColor(color: hairColor ?? .clear)
        let ciEyebrowColor = CIColor(color: eyebrowColor ?? .clear)
        
        let eye = 10 - 10*ciEyeColor.red
        let eyebrow = 10 - 10*ciEyebrowColor.red
        let hair = 10 - 10*ciHairColor.red
        
        let faceColors = [eye, eyebrow, hair, skinToneGrayScale]
        guard let faceColorMax = faceColors.max() else { return }
        guard let faceColorMin = faceColors.min() else { return }
        
        let faceContrast = faceColorMax - faceColorMin
        
        print(faceContrast)
        print("cabelo: \(hair)")
        print("olho: \(eye)")
        print("sombrancelha: \(eyebrow)")
        print("pele: \(skinToneGrayScale)")
        
        
        if (faceContrast >= 0) && (faceContrast <= 3) {
            self.contrast = 0
        }
        else if (faceContrast > 3) && (faceContrast <= 7) {
            self.contrast = 1
        }
        else {
            self.contrast = 2
        }
        
        if let contrast = self.contrast {
            print(contrast)
        }
    }
    
    private func getSkinColor() {
        guard let image = skinToneImage else { return }
        
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
    
    private func getHairColor() {
        guard let image = hairColorImage else { return }
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var graySum: Double = 0
        var alphaSum: Double = 0
        var count: Double = 0
        
        for x in 0..<pixelWidth {
            for y in 0..<pixelHeight {
                
                let scaledX = CGFloat(x) * image.scale
                let scaledY = CGFloat(y) * image.scale
                
                let point = CGPoint(x: scaledX, y: scaledY)
                let pixelInfo: Int = ((pixelWidth * Int(point.y)) + Int(point.x)) * 4
                
                let gray = Double(data[pixelInfo]) / 255.0
                let alpha = Double(data[pixelInfo + 3]) / 255.0
                
                guard (gray != 0) else { continue }
                
                graySum += gray
                alphaSum += alpha
                count += 1
            }
        }
        
        if count > 0 {
            let color = UIColor(red: graySum / Double(count), green: graySum / Double(count), blue: graySum / Double(count), alpha: graySum / Double(count))
            
            hairColor = color
        }
    }
    
    private func getEyeColor() {
        guard let image = eyeColorImage else { return }
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var graySum: Double = 0
        var alphaSum: Double = 0
        var count: Double = 0
        
        for x in 0..<pixelWidth {
            for y in 0..<pixelHeight {
                
                let scaledX = CGFloat(x) * image.scale
                let scaledY = CGFloat(y) * image.scale
                
                let point = CGPoint(x: scaledX, y: scaledY)
                let pixelInfo: Int = ((pixelWidth * Int(point.y)) + Int(point.x)) * 4
                
                let gray = Double(data[pixelInfo]) / 255.0
                let alpha = Double(data[pixelInfo + 3]) / 255.0
                
                guard (gray != 0) else { continue }
                
                graySum += gray
                alphaSum += alpha
                count += 1
            }
        }
        
        if count > 0 {
            let color = UIColor(red: graySum / Double(count), green: graySum / Double(count), blue: graySum / Double(count), alpha: graySum / Double(count))
            
            eyeColor = color
        }
    }
    
    private func getEyebrowColor() {
        guard let image = eyebrowColorImage else { return }
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var graySum: Double = 0
        var alphaSum: Double = 0
        var count: Double = 0
        
        for x in 0..<pixelWidth {
            for y in 0..<pixelHeight {
                
                let scaledX = CGFloat(x) * image.scale
                let scaledY = CGFloat(y) * image.scale
                
                let point = CGPoint(x: scaledX, y: scaledY)
                let pixelInfo: Int = ((pixelWidth * Int(point.y)) + Int(point.x)) * 4
                
                let gray = Double(data[pixelInfo]) / 255.0
                let alpha = Double(data[pixelInfo + 3]) / 255.0
                
                guard (gray != 0) else { continue }
                
                graySum += gray
                alphaSum += alpha
                count += 1
            }
        }
        
        if count > 0 {
            let color = UIColor(red: graySum / Double(count), green: graySum / Double(count), blue: graySum / Double(count), alpha: graySum / Double(count))
            
            eyebrowColor = color
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
        guard let leftEye = observation.landmarks?.leftEye?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let leftPupil = observation.landmarks?.leftPupil?.pointsInImage(imageSize: inputImage.size) else { return }
        
        guard let rightEye = observation.landmarks?.rightEye?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let rightPupil = observation.landmarks?.rightPupil?.pointsInImage(imageSize: inputImage.size) else { return }
        
        guard let leftPupilPoint = leftPupil.first else { return }
        guard let rightPupilPoint = rightPupil.first else { return }
        
        guard let leftEyebrow = observation.landmarks?.leftEyebrow?.pointsInImage(imageSize: inputImage.size) else { return }
        guard let rightEyebrow = observation.landmarks?.rightEyebrow?.pointsInImage(imageSize: inputImage.size) else { return }
        
        let boundingBox = observation.boundingBox
        
        getSkin(faceContour: faceContour, outerLips: outerLips, nose: nose, boundingBox: boundingBox)
        
        getEye(leftEye: leftEye, leftPupilPoint: leftPupilPoint, rightEye: rightEye, rightPupilPoint: rightPupilPoint)
        
        getEyebrow(leftEyebrow: leftEyebrow, rightEyebrow: rightEyebrow)
        
        getHair(facePoints: faceContour)
    }
    
    private func getHair(facePoints: [CGPoint]) {
        
        let mid = facePoints.count / 2
        
        let hairPoint = facePoints[mid]
        
        var path = Path()
        path.addArc(center: hairPoint, radius: 200, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        DispatchQueue.main.async {
            self.renderHairImage(path: path)
        }
        
    }
    
    private func getEye(leftEye: [CGPoint], leftPupilPoint: CGPoint, rightEye: [CGPoint], rightPupilPoint: CGPoint) {
        
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
        
        createEyeImageMask(leftIrisPoints: leftIrisPoints, leftRadius: leftRadius, rightIrisPoints: rightIrisPoints, rightRadius: rightRadius)
    }
    
    private func getEyebrow(leftEyebrow: [CGPoint], rightEyebrow: [CGPoint]) {
        
        let leftEyebrowPoint = CGPoint(x: (leftEyebrow[1].x + leftEyebrow[4].x)/2, y: (leftEyebrow[1].y + leftEyebrow[4].y)/2)
        let leftRadius = (leftEyebrow[1].y - leftEyebrow[2].y)*0.3
        
        let rightEyebrowPoint = CGPoint(x: (rightEyebrow[1].x + rightEyebrow[4].x)/2, y: (rightEyebrow[1].y + rightEyebrow[4].y)/2)
        let rightRadius = (rightEyebrow[1].y - rightEyebrow[2].y)*0.3
        
        createEyebrowImageMask(leftEyebrowPoint: leftEyebrowPoint, leftRadius: leftRadius, righteyebrowPoint: rightEyebrowPoint, rightRadius: rightRadius)
    }
    
    private func createEyebrowImageMask(leftEyebrowPoint: CGPoint, leftRadius: CGFloat, righteyebrowPoint: CGPoint, rightRadius: CGFloat) {
        
        let leftEyebrow = CGPoint(x: leftEyebrowPoint.x, y: (inputImage.size.height - leftEyebrowPoint.y))
        let rightEyebrow = CGPoint(x: righteyebrowPoint.x, y: (inputImage.size.height - righteyebrowPoint.y))
        
        var path = Path()
        
        path.addArc(center: leftEyebrow, radius: leftRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        path.addArc(center: rightEyebrow, radius: rightRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
        DispatchQueue.main.async {
            self.renderEybrowImage(path: path)
        }
        
    }
    
    private func createEyeImageMask(leftIrisPoints: [CGPoint], leftRadius: CGFloat, rightIrisPoints: [CGPoint], rightRadius: CGFloat) {
        
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
            self.renderEyeImage(path: path)
        }
    }
    
    
    private func getSkin(faceContour: [CGPoint], outerLips: [CGPoint], nose: [CGPoint], boundingBox: CGRect) {
        
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
        
        createSkinToneImageMask(leftCheek: leftCheek, leftCheekRadius: leftCheekRadius, rightCheek: rightCheek, rightCheekRadius: rightCheekRadius, nose: nosePoint, noseRadius: noseRadius, forehead: forehead, foreheadRadius: foreheadRadius)
        
    }
    
    private func createSkinToneImageMask(leftCheek: CGPoint, leftCheekRadius: CGFloat, rightCheek: CGPoint, rightCheekRadius: CGFloat, nose: CGPoint, noseRadius: CGFloat, forehead: CGPoint, foreheadRadius: CGFloat) {
        
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
            self.renderSkinToneImage(path: path)
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
        filter.contrast = 1.0
        
        guard let outputImage = filter.outputImage else { return }
        guard let cgOutputImage = contex.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        grayScaleImage = UIImage(cgImage: cgOutputImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
    }
    
    
    @MainActor private func renderSkinToneImage(path: Path) {
        let render = ImageRenderer(content:
            Image(uiImage: inputImage)
                .frame(width: inputImage.size.width, height: inputImage.size.height)
                .mask(alignment: .center, {
                    FaceContourShape(facePath: path)
                }))
        
        skinToneImage = render.uiImage
    }
    
    @MainActor private func renderEyeImage(path: Path) {
        let render = ImageRenderer(content:
                                     
            Image(uiImage: grayScaleImage ?? inputImage)
                .frame(width: inputImage.size.width, height: inputImage.size.height)
                .mask(alignment: .center, {
                    FaceContourShape(facePath: path)
                }))
        
        eyeColorImage = render.uiImage
    }
    
    @MainActor private func renderHairImage(path: Path) {
        let render = ImageRenderer(content:
                                     
            Image(uiImage: grayScaleImage ?? inputImage)
                .frame(width: inputImage.size.width, height: inputImage.size.height)
                .mask(alignment: .center, {
                    FaceContourShape(facePath: path)
                }))
        
        hairColorImage = render.uiImage
    }
    
    @MainActor private func renderEybrowImage(path: Path) {
        let render = ImageRenderer(content:
                                     
            Image(uiImage: grayScaleImage ?? inputImage)
                .frame(width: inputImage.size.width, height: inputImage.size.height)
                .mask(alignment: .center, {
                    FaceContourShape(facePath: path)
                }))
        
        eyebrowColorImage = render.uiImage
    }
}
