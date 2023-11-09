//
//  PositiveFeedbackView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct PositiveFeedbackView: View {
    var body: some View {
        NavigationView {
            VStack (spacing: 40){
                Image("posFeedback")
                                
                Text("Tudo certo! Identificamos que você possui afinidade com o perfil de")
                    .font(Font.custom("SF Pro Rounded", size: 19)
                    .weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
                
                Image("primaveraPura")
                
                NavigationLink {
                    ResultsView()
                } label: {
                    SeeResultsBotton()
                        .frame(width: 361, height: 50, alignment: .center)
                        .padding(.top, 50)
                }
                .foregroundStyle(.accent)
            }
            //.navigationTitle("Teste colorimetria")
            //.navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct SeeResultsBotton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .padding(.horizontal)
                .padding(.vertical, 3)
            Text("Ver resultado")
                .font(Font.custom("SF Pro Rounded", size: 19)
                .weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    PositiveFeedbackView()
}
