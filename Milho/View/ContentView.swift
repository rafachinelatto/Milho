//
//  ContentView.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    
    let image = UIImage(named: "teste")!
    @ObservedObject var segmentation = ImageSegmentation()
    @ObservedObject var imageQuality = FaceImageQuality()
    @State var processedImage: UIImage?
    @State var quality: Float?
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        .onAppear {
            imageQuality.inputImage = image
            imageQuality.faceQuality()
            quality = imageQuality.quality
        }
        
        if let imageQuality = self.quality {
            Text("\(imageQuality)")
        }
        
        if let processedImage {
            Image(uiImage: processedImage)
                .resizable()
                .scaledToFit()
        } else {
            Button("Process Image") {
                segmentation.inputImage = image
                segmentation.segmentImage()
                
                if let outputImage = segmentation.outputImage {
                    processedImage = outputImage
                    imageQuality.inputImage = outputImage
                    imageQuality.faceQuality()
                    quality = imageQuality.quality
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
