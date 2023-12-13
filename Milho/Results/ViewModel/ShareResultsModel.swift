//
//  ShareResultsModel.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 13/12/23.
//

import Foundation
import SwiftUI

class ShareResultsModel {
    @MainActor func shareImage(paletteNumberResult: Int) -> UIImage {
        
        var rectangles: [String] {
            var hexColors: [String] = []
            for i in 0...5 {
                hexColors.append(palette.idealColors[i].hexCode)
            }
            return hexColors
        }
        
        var palette: ColorPalette {
            paletteList[paletteNumberResult]
        }
        
        let renderer = ImageRenderer(content:
                                        
                                        
                                        VStack (spacing: 16){
            
            Image("share")
            
            VStack (spacing: 16){
                Text("O app #forHue me classificou como")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                
                VStack {
                    Image(palette.backgroundImage)
                    //Change for something like Image(colorTone) in which colorTone var value comes from CoreData after coloring test (automatic/manual) taken
                    
                    HStack (spacing: 16){
                        //Change ForEach with Best color options list instead of rectangles list constant
                        ForEach(rectangles, id: \.self) {index in
                            Rectangle()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                                .foregroundColor(Color(hex: index)) //UIColor("Loaded color")
                        }
                    }
                }
                
            }
            
        }
            
            .padding()
            .mask(RoundedRectangle(cornerSize: CGSize(width: 30, height: 30)))
        )
        
        renderer.scale = 3.0
        
        if let image = renderer.uiImage {
            return image
        } else {
            return UIImage()
        }
    }
}

