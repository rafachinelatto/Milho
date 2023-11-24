//
//  PositiveFeedbackView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct PositiveFeedbackView: View {
    
    @AppStorage("result") var result: Bool?
    let rectangles = [1,2,3,4,5,6]
    
    var body: some View {
        NavigationView {
            VStack (spacing: 48){
                VStack (spacing: 32){
                    Image("posFeedback")
                                    
                    Text("Tudo certo! Identificamos que você possui afinidade com o perfil de")
                        .font(Font.custom("SF Pro Rounded", size: 19)
                        .weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        
                    
                    Image("primaveraPura")
                    //Change for something like Image(colorTone) in which colorTone var value comes from CoreData after coloring test (automatic/manual) taken
                    
                    HStack (spacing: 16){
                        //Change ForEach with Best color options list instead of rectangles list constant
                        ForEach(rectangles, id: \.self) {index in
                            Rectangle()
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                                .foregroundColor(.accentColor) //UIColor("Loaded color")
                            }
                        }
                    }
                Button {
                    result = true
                } label: {
                    Text("Ver paleta de cores completa")
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/20)
                }
                .buttonStyle(.borderedProminent)
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
    PositiveFeedbackView()
}
