//
//  ImageComparisonTableCellViewModel.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 06/12/23.
//

import SwiftUI
import Vision


class ImageComparisonTableCellViewModel: ObservableObject {
    
    @Published var cutImage: UIImage?
    
    func getRect(image: UIImage) {
        
        guard let cgImage = image.cgImage else { return }
        let imageOrientation = CGImagePropertyOrientation(image.imageOrientation)
        
        let request = VNDetectFaceLandmarksRequest(completionHandler: {(request: VNRequest, error: Error?) in
            
            if let requestError = error as NSError? {
                print(requestError.localizedDescription)
                
                return
            }
            
            guard let observations = request.results as? [VNFaceObservation] else { return }
            
            guard let observation = observations.first else { return }
            
            guard let faceContour = observation.landmarks?.faceContour?.pointsInImage(imageSize: image.size) else { return }
            
            
            
            self.createRectPath(faceContour: faceContour, image: image)
        })
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: imageOrientation, options: [:])
        
        DispatchQueue.main.async {
            do {
                try requestHandler.perform([request])
            } catch let error as NSError {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    private func createRectPath(faceContour: [CGPoint], image: UIImage) {
        var minYPoint: CGPoint = .zero
        
        for i in 0..<faceContour.count {
            if i == 0 {
                minYPoint = faceContour[i]
            } else {
                if minYPoint.y > faceContour[i].y {
                    minYPoint = faceContour[i]
                }
            }
        }
        
        let minY = image.size.height - minYPoint.y + 30
        
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: minY))
        path.addLine(to: CGPoint(x: image.size.width, y: minY))
        path.addLine(to: CGPoint(x: image.size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        
        DispatchQueue.main.async {
            self.renderCutImage(path: path, image: image)
        }
        
    }
    
    @MainActor private func renderCutImage(path: Path, image: UIImage) {
        let render = ImageRenderer(content:
                                    Image(uiImage: image)
            .frame(width: image.size.width, height: image.size.height)
            .mask(alignment: .center, {
                FaceContourShape(facePath: path)
            }))
        
        cutImage = render.uiImage
    }
    
}
