//
//  LoadingInfoView.swift
//  Milho
//
//  Created by Anderson  Vulto on 09/11/23.
//
import SwiftUI

struct LoadingInfoView: View {
    
    let constrains = ["Contraste", "Temperatura", "Profundidade", "Intensidade"]
    
    var body: some View {
        
        VStack {
            ForEach (constrains, id: \.self) {const in
                HStack (spacing: 8){
                    LoadingItemCell()
                    Text(const)
                    Spacer()
                }
                .padding(8)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width/2.4)
        .padding()
        
        
        
        
    }
}

#Preview {
    LoadingInfoView()
}
