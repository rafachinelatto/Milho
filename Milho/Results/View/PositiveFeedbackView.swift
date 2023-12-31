//
//  PositiveFeedbackView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct PositiveFeedbackView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("paletteNumber") var paletteNumber: Int?
    @AppStorage("result") var result: Bool?
    //let rectangles = [1,2,3,4,5,6]
    var paletteNumberResult: Int
    
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
    
    var body: some View {
        NavigationView {
            VStack (spacing: 16){
                VStack (spacing: 16){
                    Image("posFeedback")
                    
                    Text("Tudo certo! Identificamos que você possui afinidade com o perfil de")
                    //.frame(maxWidth: .infinity)
                        .font(.body)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
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
                
                Spacer()
                
                Button {
                    
                    self.presentationMode.wrappedValue.dismiss()
                    result = false
                    paletteNumber = paletteNumberResult
                    
                    //                    result = true
                    //                    paletteNumber = paletteNumberResult
                } label: {
                    Text("Ver paleta de cores completa")
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/20)
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            
            
        }
        
        
        
        
        
        //.navigationTitle("Teste colorimetria")
        //.navigationBarTitleDisplayMode(.automatic)
    }
}

//struct SeeResultsBotton: View {
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
//                .padding(.horizontal)
//                .padding(.vertical, 3)
//            Text("Ver paleta de cores completa")
//                .font(Font.custom("SF Pro Rounded", size: 19)
//                .weight(.medium))
//                .multilineTextAlignment(.center)
//                .foregroundColor(.white)
//        }
//    }
//}

#Preview {
    PositiveFeedbackView(paletteNumberResult: 11)
}
