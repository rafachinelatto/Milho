//
//  ColorAnalysis.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 30/10/23.
//

import SwiftUI
import SimpleMatrixKit
import SwiftCluster

class ColorAnalysis: ObservableObject {
    
    @Published var outputImage: UIImage?
    
    func findColors(_ inputImage: UIImage) -> [UIColor] {
        
//        let imageResized = inputImage.resized(withPercentage: 1, isOpaque: true)
//        guard let image = imageResized else { return [] }
//        
//        print(image.size)
//        print(image.scale)
//        print()
//        print(inputImage.size)
//        print(inputImage.scale)
        
        let imageCompressed = inputImage.thumbnail(compression: 0.4)
        guard let image = imageCompressed else { return [] }
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return [] }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var imageColors: [UIColor] = []
        for x in 0..<pixelWidth {
            for y in 0..<pixelHeight {
                let scaledX = CGFloat(x)
                let scaledY = CGFloat(y)
                
                let point = CGPoint(x: scaledX, y: scaledY)
                let pixelInfo: Int = ((pixelWidth * Int(point.y)) + Int(point.x)) * 4
                
                let red = CGFloat(data[pixelInfo]) / 255.0
                let green = CGFloat(data[pixelInfo + 1]) / 255.0
                let blue = CGFloat(data[pixelInfo + 2]) / 255.0
                let alpha = CGFloat(data[pixelInfo + 3]) / 255.0
                
                guard (red != 0) || (green != 0) || (blue != 0) else { continue }
                
                let color = UIColor(red: red,
                                    green: green,
                                    blue: blue,
                                    alpha: alpha )
               
                imageColors.append(color)
                
            }
        }
        print(imageColors.count)
        return imageColors
    }
    
    
    func findColorsV2(_ inputImage: UIImage) -> [UIColor] {

        let imageCompressed = inputImage.thumbnail(compression: 0.1)
        outputImage = imageCompressed
        guard let image = imageCompressed else { return [] }
        
        
        let pixelWidth = Int(image.size.width)
        let pixelHeight = Int(image.size.height)
        
        guard let pixelData = image.cgImage?.dataProvider?.data else { return [] }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
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
        
        let pixelColorData = Matrix(array2D: colorArray)
        print(pixelColorData.count)
        let clusterColorMatrix = performClusterAnalysis(pixelColorData)
        var uiColorArray: [UIColor] = []
        
        for i in 0..<20 {
            print(clusterColorMatrix[i])
        
            let color = UIColor(red: clusterColorMatrix[i][0], green: clusterColorMatrix[i][1], blue: clusterColorMatrix[i][2], alpha: clusterColorMatrix[i][3])
            uiColorArray.append(color)
        }
        return uiColorArray
    }

    
    private func performClusterAnalysis(_ pixelColorData: Matrix<Double>) -> Matrix<Double> {
        let model = ClusterModel(
            data: pixelColorData,
            numberOfGroups: 20,
            initializationRule: .forgy,
            stoppingRules: [.distanceChange(percent: 0.01)],
            showDiagnostics: true
        )
        
        let (_, meanColors) = model.run()
        
        return meanColors
    }    
}
