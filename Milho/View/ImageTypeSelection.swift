//
//  ImageTypeSelection.swift
//  Milho
//
//  Created by Ana Elisa Lima on 26/10/23.
//

import SwiftUI

struct ImageTypeSelection: View {
    @StateObject var homeData = ImageTypeViewModel()
    @ObservedObject var segmentation = ImageSegmentation()
    @ObservedObject var imageQuality = FaceImageQuality()
    
    @State var imageSelected: UIImage?
    @State var showImagePicker: Bool = false
    @State var showActionSheet: Bool = false
    @State var sourceType: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                
                
//                if !homeData.allImages.isEmpty && homeData.mainView != nil {
//                    Image(uiImage: homeData.mainView.image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: UIScreen.main.bounds.width)
//                    
//                    Text("Tem certeza de que deseja analisar esta foto?")
//                        .padding()
//                }
                
                if let image = imageSelected {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    if let outputImage = segmentation.outputImage {
                        Image(uiImage: outputImage)
                            .resizable()
                            .scaledToFill()
                            .padding()
                    } else {
                        Button("Segmentar imagem") {
                            segmentation.inputImage = image
                            segmentation.segmentImage()
                        }
                        .padding()
                    }
                    
                }
                
                else if homeData.imageData.count == 0 {
                    InitialSelectButton(showActionSheet: $showActionSheet)
                        .actionSheet(isPresented: $showActionSheet, content: { () -> ActionSheet in
                            ActionSheet(title: Text("Select Image"), message: Text("Please select an image from the image gallery or use the camera"), buttons: [
                                ActionSheet.Button.default(Text("Camera"), action: {
                                    self.sourceType = 0
                                    self.showImagePicker.toggle()
                                    
                                }),
                                ActionSheet.Button.default(Text("Photo Gallery"), action: {
                                    self.sourceType = 1
                                    self.showImagePicker.toggle()
                                    
                                }),
                                ActionSheet.Button.cancel()
                            ])
                        })
                }
                
                else {
                    // Loading View...
                    ProgressView()
                }
            }
            if showImagePicker {
                ImagePicker(selectedImage: $imageSelected, isVisible: $showImagePicker, sourceType: sourceType)
            }
        }
    }
}

#Preview {
    ImageTypeSelection()
}
