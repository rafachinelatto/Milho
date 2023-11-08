//
//  LoadingImageView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct Item: View {
    let label: String
    
    var body: some View {
        HStack{
            ProgressView()
                .padding(.trailing, 1)
            Text(label)
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
        }
    }
}

struct Loading: View {
    let indeterminateLoading = [GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: indeterminateLoading,alignment: .center ,spacing: 20) {
            Item(label: "Contraste")
            Item(label: "Temperatura")
            Item(label: "Profundidade")
            Item(label: "Intensidade")
        }
    }
}


#Preview {
    Loading()
}
