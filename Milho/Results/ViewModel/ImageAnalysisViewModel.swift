//
//  ImageAnalysisViewModel.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 26/11/23.
//

import SwiftUI
import Vision
import CoreImage

enum ColorPallet {
    case invernoPuro
    case invernoIntenso
    case invernoProfundo
    case verãoPuro
    case verãoSuave
    case verãoClaro
    case outonoPuro
    case outonoSuave
    case outonoProfundo
    case primaveraPura
    case primaveraIntensa
    case primaveraClara
    
}

class ImageAnalysisViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed
        case loaded
    }
    
    @Published private(set) var state = State.idle
    @Published var colorPallet: ColorPallet?
    @Published var skinColorImage: UIImage?
    
    func getColorPallet(image: UIImage) {
        
        self.state = .loading
        //guard let cgImage = image.cgImage else { return }
        guard let ciImage = CIImage(image: image) else { return }
        ciImage.oriented(CGImagePropertyOrientation(image.imageOrientation))
        
        var skinRects: [CGRect] = []
        var eyeRects: [CGRect] = []
        //        var eyebrowRects: [CGRect] = []
        //        var hairRects: [CGRect] = []
        
        let imageOrientation = CGImagePropertyOrientation(image.imageOrientation)
        
        let request = VNDetectFaceLandmarksRequest(completionHandler: {(request: VNRequest, error: Error?) in
            
            if let requestError = error as NSError? {
                print(requestError.localizedDescription)
                
                // Implemetar lógica para escolher outra imagem caso necessário.
                
                return
            }
            
            guard let observations = request.results as? [VNFaceObservation] else { return }
            
            guard let observation = observations.first else { return }
            
            let boundingBox = observation.boundingBox
            
            
            
            guard let faceCoutour = observation.landmarks?.faceContour?.normalizedPoints else { return }
            var faceContourImage: [CGPoint] = []
            for i in 0..<faceCoutour.count {
                let point = faceCoutour[i].convertToImagePoint(ciImage, boundingBox)
                faceContourImage.append(point)
            }
            
            guard let outerLips = observation.landmarks?.outerLips?.normalizedPoints else { return }
            var outerLipsImage: [CGPoint] = []
            for i in 0..<outerLips.count {
                let point = outerLips[i].convertToImagePoint(ciImage, boundingBox)
                outerLipsImage.append(point)
            }
            
            guard let nose = observation.landmarks?.nose?.normalizedPoints else { return }
            var noseImage: [CGPoint] = []
            for i in 0..<nose.count {
                let point = nose[i].convertToImagePoint(ciImage, boundingBox)
                noseImage.append(point)
            }
            
            guard let leftEye = observation.landmarks?.leftEye?.normalizedPoints else { return }
            var leftEyeImage: [CGPoint] = []
            for i in 0..<leftEye.count {
                let point = leftEye[i].convertToImagePoint(ciImage, boundingBox)
                leftEyeImage.append(point)
            }
            
            guard let leftPupil = observation.landmarks?.leftPupil?.normalizedPoints.first?.convertToImagePoint(ciImage, boundingBox) else { return }
            
            guard let rightEye = observation.landmarks?.rightEye?.normalizedPoints else { return }
            var rightEyeImage: [CGPoint] = []
            for i in 0..<rightEye.count {
                let point = rightEye[i].convertToImagePoint(ciImage, boundingBox)
                rightEyeImage.append(point)
            }
            
            guard let rightPupil = observation.landmarks?.rightPupil?.normalizedPoints.first?.convertToImagePoint(ciImage, boundingBox) else { return }
            
            guard let leftEyebrow = observation.landmarks?.leftEyebrow?.normalizedPoints else { return }
            var leftEyebrowImage: [CGPoint] = []
            for i in 0..<leftEyebrow.count {
                let point = leftEyebrow[i].convertToImagePoint(ciImage, boundingBox)
                leftEyebrowImage.append(point)
            }
            
            guard let rightEyebrow = observation.landmarks?.rightEyebrow?.normalizedPoints else { return }
            var rightEyebrowImage: [CGPoint] = []
            for i in 0..<rightEyebrow.count {
                let point = rightEyebrow[i].convertToImagePoint(ciImage, boundingBox)
                rightEyebrowImage.append(point)
            }
            
            skinRects = self.getSkinRects(faceContour: faceContourImage, outerLips: outerLipsImage, nose: noseImage)
            eyeRects = self.getEyeRects(leftEye: leftEyeImage, leftPupilPoint: leftPupil, rightEye: rightEyeImage, rightPupilPoint: rightPupil)
            
        })
        
        //let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: imageOrientation, options: [:])
        let requestHandler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try requestHandler.perform([request])
        } catch let error as NSError {
            
            // Implementar lógica para escolher outra imagem caso necessário.
            
            print(error.localizedDescription)
            return
        }
        
        //let skinColor = getAverageColor(image: ciImage, rects: skinRects)
        let eyeColor = getAverageColor(image: ciImage, rects: [eyeRects[1]])
        
        
        self.state = .loaded
    }
    
    private func getSkinRects(faceContour: [CGPoint], outerLips: [CGPoint], nose: [CGPoint]) -> [CGRect] {
        
        guard let faceContourMinX = faceContour.last else { return [] }
        guard let faceContourMaxX = faceContour.first else { return [] }
        
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
        
        let leftCheekSize = sqrt((pow((outerLipsMinX.x - faceContourMinX.x), 2)) + pow((outerLipsMinX.y - faceContourMinX.y), 2)) * 0.2
        
        let leftCheekOrigin = CGPoint(x: ((outerLipsMinX.x + faceContourMinX.x) / 2) - leftCheekSize*0.5 , y: ((outerLipsMinX.y + faceContourMinX.y) / 2) - leftCheekSize*0.5)
        
        let leftCheekRect = CGRect(origin: leftCheekOrigin, size: CGSize(width: leftCheekSize, height: leftCheekSize))
        
        
        let rightCheekSize = sqrt((pow((outerLipsMaxX.x - faceContourMaxX.x), 2)) + pow((outerLipsMaxX.y - faceContourMaxX.y), 2)) * 0.2
        
        let rightCheekOrigin = CGPoint(x: ((outerLipsMaxX.x + faceContourMaxX.x) / 2) - rightCheekSize*0.5 , y: ((outerLipsMaxX.y + faceContourMaxX.y) / 2) - rightCheekSize*0.5)
        
        let rightCheekRect = CGRect(origin: rightCheekOrigin, size: CGSize(width: rightCheekSize, height: rightCheekSize))
        
        var noseMax = CGPoint.zero
        var noseMin = CGPoint.zero
        
        for i in 0..<nose.count {
            if i == 0 {
                noseMax = nose[i]
                noseMin = nose[i]
            } else {
                if noseMax.x < nose[i].x {
                    noseMax = nose[i]
                }
                if noseMin.x > nose[i].x {
                    noseMin = nose[i]
                }
            }
        }
        
        
        let noseSize = sqrt((pow(noseMax.x - noseMin.x, 2)) + (pow(noseMax.y - noseMin.y, 2))) * 0.3
        
        let noseOrigin = CGPoint(x: ((noseMax.x + noseMin.x) / 2) - noseSize*0.5, y: ((noseMax.y + noseMin.y) / 2) - noseSize*0.5)
        
        let noseRect = CGRect(origin: noseOrigin, size: CGSize(width: noseSize, height: noseSize))
        
        return [leftCheekRect, rightCheekRect, noseRect]
    }
    
    
    private func getEyeRects(leftEye: [CGPoint], leftPupilPoint: CGPoint, rightEye: [CGPoint], rightPupilPoint: CGPoint) -> [CGRect] {
        
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
        
        let leftEyeRectsSize = leftIrisRadius * 10
        let rightEyeRectsSize = rightIrisRadius * 0.05
        
        var leftIrisOriginPoints: [CGPoint] = []
        var rightIrisOriginPoints: [CGPoint] = []
        
        leftIrisOriginPoints.append(CGPoint(x: leftPupilPoint.x - leftEyeRectsSize*0.5, y: leftPupilPoint.y - leftEyeRectsSize*0.5))
        leftIrisOriginPoints.append(CGPoint(x: leftPupilPoint.x + leftIrisRadius*0.1, y: leftPupilPoint.y))
        
        leftIrisOriginPoints.append(CGPoint(x: (leftPupilPoint.x + leftIrisRadius * 0.4) - leftEyeRectsSize*0.5, y: leftPupilPoint.y - leftEyeRectsSize*0.5))
        leftIrisOriginPoints.append(CGPoint(x: (leftPupilPoint.x - leftIrisRadius * 0.4) - leftEyeRectsSize*0.5, y: leftPupilPoint.y - leftEyeRectsSize*0.5))
        leftIrisOriginPoints.append(CGPoint(x: leftPupilPoint.x - leftEyeRectsSize*0.5, y: (leftPupilPoint.y - leftIrisRadius * 0.4) - leftEyeRectsSize*0.5))
        
        rightIrisOriginPoints.append(CGPoint(x: (rightPupilPoint.x + rightIrisRadius * 0.4) - rightEyeRectsSize*0.5, y: rightPupilPoint.y - rightEyeRectsSize*0.5))
        rightIrisOriginPoints.append(CGPoint(x: (rightPupilPoint.x - rightIrisRadius * 0.4) - rightEyeRectsSize*0.5, y: rightPupilPoint.y - rightEyeRectsSize*0.5))
        rightIrisOriginPoints.append(CGPoint(x: rightPupilPoint.x - rightEyeRectsSize*0.5, y: (rightPupilPoint.y - rightIrisRadius * 0.4) - rightEyeRectsSize*0.5))
        
        
        var eyeRects: [CGRect] = []
        
        for i in 0..<leftIrisOriginPoints.count {
            let rect = CGRect(origin: leftIrisOriginPoints[i], size: CGSize(width: leftEyeRectsSize, height: leftEyeRectsSize))
            eyeRects.append(rect)
        }
        
        for i in 0..<rightIrisOriginPoints.count {
            let rect = CGRect(origin: rightIrisOriginPoints[i], size: CGSize(width: rightEyeRectsSize, height: rightEyeRectsSize))
            eyeRects.append(rect)
        }
        
        return eyeRects
    }
    
    
    private func getAverageColor(image: CIImage, rects: [CGRect]) -> UIColor? {
       
        let size = CGSize(width: 40, height: 40)
        
        let width = Int(size.width)
        let height = Int(size.height)
        let totalPixels = width * height
        
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for i in 0..<rects.count {
            let croppedImage = image.cropped(to: rects[i])
            guard let cgCroppedImage = CIContext().createCGImage(croppedImage, from: croppedImage.extent) else { return nil }
            
            skinColorImage = UIImage(cgImage: cgCroppedImage)
                
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
            
            guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo) else { return nil }

            context.draw(cgCroppedImage, in: CGRect(origin: .zero, size: size))
            
            guard let pixelBuffer = context.data else { return nil }
            
            let pointer = pixelBuffer.bindMemory(to: UInt32.self, capacity: totalPixels)
            
            for x in 0..<width {
                for y in 0..<height {
                    
                    let pixel = pointer[(y * width) + x]
                    
                    let r = red(for: pixel)
                    let g = green(for: pixel)
                    let b = blue(for: pixel)
                    
                    totalRed += Int(r)
                    totalGreen += Int(g)
                    totalBlue += Int(b)
                    
                }
            }
        }
        
        let averageRed = CGFloat(totalRed) / CGFloat(totalPixels * rects.count)
        let averageGreen = CGFloat(totalGreen) / CGFloat(totalPixels * rects.count)
        let averageBlue = CGFloat(totalBlue) / CGFloat(totalPixels * rects.count)
        
        print(averageRed)
        print(averageGreen)
        print(averageBlue)
        print()
        return UIColor(red: averageRed / 255, green: averageGreen / 255, blue: averageBlue / 255, alpha: 1.0)
    }
    
    

    private func red(for pixelData: UInt32) -> UInt8 {
        return UInt8((pixelData >> 16) & 255)
    }
    
    private func green(for pixelData: UInt32) -> UInt8 {
            return UInt8((pixelData >> 8) & 255)
    }
    
    private func blue(for pixelData: UInt32) -> UInt8 {
        return UInt8((pixelData >> 0) & 255)
    }
}


extension CGPoint {
    func convertToImagePoint(_ originalImage: CIImage, _ boundingBox: CGRect) -> CGPoint {
        let imageWidth = originalImage.extent.width
        let imageHeight = originalImage.extent.height
        let vectoredPoint = vector2(Float(self.x), Float(self.y))
        let vnImagePoint = VNImagePointForFaceLandmarkPoint(vectoredPoint, boundingBox, Int(imageWidth), Int(imageHeight))
        let imagePoint = CGPoint(x: vnImagePoint.x, y: vnImagePoint.y)
        return imagePoint
    }
}
