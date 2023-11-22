//
//  ImageTypeSelection.swift
//  Milho
//
//  Created by Ana Elisa Lima on 26/10/23.
//

import SwiftUI
import SimpleMatrixKit

struct ImageTypeSelection: View {
    @StateObject var homeData = ImageTypeViewModel()
    @ObservedObject var segmentation = ImageSegmentation()
    @ObservedObject var imageQuality = FaceImageQuality()
    @ObservedObject var colorAnalysis = ColorAnalysis()
    
    
    @State var imageSelected: UIImage?
    @State var showImagePicker: Bool = false
    @State var showActionSheet: Bool = false
    @State var sourceType: Int = 0
    @State var colorArray: [UIColor] = []
    @State var pixelDataArray: [UIColor] = []
    @State var pixelNumber: Float = 0
    
    var body: some View {
        ZStack {
            VStack {
                
                
                if let image = imageSelected {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    
                        
                    switch colorAnalysis.contrast {
                    case 0:
                        Text("Contraste: Baixo")
                    case 1:
                        Text("Contraste: Médio")
                    case 2:
                        Text("Contraste: Alto")
                    default:
                        Text("Contraste não determinado")
                    }
                        
                    
                    if let skinColor = colorAnalysis.skinTone {
                        
                        Rectangle()
                            .fill(Color(skinColor))
                            .scaledToFit()
                        
                    } else {
                        Button("Get eyes") {
                            
                            colorAnalysis.inputImage = image
                            colorAnalysis.analysis()

                            
                            //                            segmentation.inputImage = image
                            //                            segmentation.segmentImage()
                            //
                            //                            if let outputImage = segmentation.outputImage {
                            //                                colorArray = colorAnalysis.findColorsV2(outputImage)
                            //                            }
                            
                        }
                        .padding()
                    }

                }
                
                
                else  {
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
                
            }
            
            
            if showImagePicker {
                ImagePicker(selectedImage: $imageSelected, isVisible: $showImagePicker, sourceType: sourceType)
            }
        }
        .navigationTitle("Coloração pessoal")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    ImageTypeSelection()
}
