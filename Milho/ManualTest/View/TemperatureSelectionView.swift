//
//  TemperatureSelectionView.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 07/12/23.
//

import SwiftUI

struct TemperatureSelectionView: View {
    
    var selected: Bool
    var icon: String
    var name: String
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 30))
                Text(name)
            }
            .padding(.bottom, 5)
            .symbolVariant(selected ? .fill : .none)
            .foregroundStyle(selected ? .accent : Color(red: 0.27, green: 0.27, blue: 0.27))
            
            if selected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.accent)
            }
            
            else {
                Image(systemName: "circle")
                    .font(.title)
                    .foregroundStyle(.gray)
            }
            
        }
    }
}

#Preview {
    TemperatureSelectionView(selected: true, icon: "flame", name: "Quente")
}
