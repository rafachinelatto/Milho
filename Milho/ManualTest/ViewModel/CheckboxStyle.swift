//
//  CheckboxStyle.swift
//  Milho
//
//  Created by Ana Elisa Lima on 13/11/23.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
         
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .accent : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                .symbolVariant(configuration.isOn ? .fill : .none)
            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
