//
//  LoadingInfoView.swift
//  Milho
//
//  Created by Anderson  Vulto on 09/11/23.
//
import SwiftUI

struct LoadingInfoView: View {
    
    let constrains = ["Contraste", "Temperatura", "Profundidade", "Intensidade"]
    
    let times = [1.0,2.0,3.0,4.0]
    
    var body: some View {
        
        VStack {
            ForEach (0..<constrains.count, id: \.self) {const in
                HStack (spacing: 8){
                    LoadingItemCell(time: times[const]*1.3)
                    Text(constrains[const])
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
