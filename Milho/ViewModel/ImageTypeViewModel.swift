//
//  ImageTypeViewModel.swift
//  Milho
//
//  Created by Ana Elisa Lima on 26/10/23.
//

import SwiftUI
import CoreImage

class ImageTypeViewModel: ObservableObject {
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)
    @Published var allImages: [DataView] = []
    
    @Published var mainView: DataView!
    
    func loadImage() {
        if UIImage(data: imageData) != nil {
            
        } else {
            
          return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            
        DispatchQueue.main.async {
            if self.mainView == nil{self.mainView = self.allImages.first}
            
            }
        }
    }
}
