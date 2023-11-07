//
//  LoadingResultsView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct LoadingResultsView: View {
    var body: some View {
            VStack (alignment: .center) {
                LoadingImage()
                    .padding(.bottom)
                Text("Estamos analisando a foto")
                    .font(Font.custom("SF Pro", size: 17)
                    .weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
                Loading()
            }
        }
    }

#Preview {
    LoadingResultsView()
}
