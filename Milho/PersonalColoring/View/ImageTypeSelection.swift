//
//  ImageTypeSelection.swift
//  Milho
//
//  Created by Ana Elisa Lima on 26/10/23.
//

import SwiftUI
import SimpleMatrixKit

struct ImageTypeSelection: View {

    @State var imageWasSelected = false
    @State var imageSelected: UIImage?
    @State var showImagePicker: Bool = false
    @State var showActionSheet: Bool = false
    @State var sourceType: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                                
                if !imageWasSelected  {
                    InitialSelectButton(showActionSheet: $showActionSheet)
                        .actionSheet(isPresented: $showActionSheet, content: { () -> ActionSheet in
                            ActionSheet(title: Text("Select Image"), message: Text("Please select an image from the image gallery or use the camera"), buttons: [
                                ActionSheet.Button.default(Text("Camera"), action: {
                                    self.sourceType = 0
                                    self.showImagePicker = true
                                    
                                }),
                                ActionSheet.Button.default(Text("Photo Gallery"), action: {
                                    self.sourceType = 1
                                    self.showImagePicker = true
                                    
                                }),
                                ActionSheet.Button.cancel()
                            ])
                        })
                }
                
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $imageSelected, imageWasSelected: $imageWasSelected, sourceType: sourceType)
            }
            .navigationDestination(isPresented: $imageWasSelected) {
                if let image = imageSelected {
                    AnalyzingImageView(image: image)
                        .navigationBarBackButtonHidden()
                        .toolbar(.hidden, for: .tabBar)
                }
            }
            
            
            
//            if showImagePicker {
//                ImagePicker(selectedImage: $imageSelected, sourceType: sourceType)
//            }
        }
        .navigationTitle("Coloração pessoal")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    ImageTypeSelection()
}
