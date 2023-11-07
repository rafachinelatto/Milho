//
//  NegativeFeedbackView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct NegativeFeedbackView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("negFeedback")
                
                Text("Infelizmente não foi possível analisar sua foto")
                    .font(Font.custom("SF Pro Rounded", size: 19)
                    .weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 359, alignment: .top)
                    .padding()
                
                Text("Tente tirar/escolher uma foto com boa iluminação, em que seu rosto, olhos e cabelos estão visíveis ")
                    .font(Font.custom("SF Pro Rounded", size: 19))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    .frame(width: 353, alignment: .top)
                
                NavigationLink {
                    InitialSelectButton(showActionSheet: .constant(true))
                } label: {
                    ReturnBotton()
                        .frame(width: 361, height: 50, alignment: .center)
                        .padding(.top, 50)
                }
                .foregroundStyle(.accent)
            }
            .navigationTitle("Teste colorimetria")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct ReturnBotton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                .padding(.horizontal)
                .padding(.vertical, 3)
            Text("Tente novamente")
                .font(Font.custom("SF Pro Rounded", size: 19)
                .weight(.medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    NegativeFeedbackView()
}
