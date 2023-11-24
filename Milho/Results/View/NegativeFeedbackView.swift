//
//  NegativeFeedbackView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct NegativeFeedbackView: View {
    
    @State private var takePhotoActive = false
    @State private var tabBarActive = false
    
    var body: some View {
        if takePhotoActive {
            ImageTypeSelection()
        }
        else if tabBarActive {
            TabBar()
        } else {
            NavigationView {
                VStack (spacing: 64){
                    VStack (spacing: 24) {
                        Image("negFeedback")
                        
                        Text("Infelizmente não foi possível analisar sua foto")
                            .font(Font.custom("SF Pro Rounded", size: 19)
                            .weight(.medium))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 359, alignment: .top)
                            .padding()
                        
                        Text("Tente tirar ou escolher uma foto com boa iluminação, em que seu rosto, olhos e cabelos estejam visíveis ")
                            .font(Font.custom("SF Pro Rounded", size: 19))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .frame(width: 353, alignment: .top)
                    }
                    
                    VStack (spacing: 8) {
                        Button(action: {
                            takePhotoActive = true
                        }, label: {
                            Text("Tire outra foto")
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/20)
                        })
                        .buttonStyle(.borderedProminent)
                        
                        Button(action: {
                            tabBarActive = true
                        }, label: {
                            Text("Não quero completar meu teste agora")
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/20)
                        })
                        .buttonStyle(.borderless)
                        }
                    
                        
                    }
                .padding()
                
                
                
            }
        }
        }
    }

//struct ReturnBotton: View {
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
//                .padding(.horizontal)
//                .padding(.vertical, 3)
//            Text("Tente novamente")
//                .font(Font.custom("SF Pro Rounded", size: 19)
//                .weight(.medium))
//                .multilineTextAlignment(.center)
//                .foregroundColor(.white)
//        }
//    }
//}

#Preview {
    NegativeFeedbackView()
}
