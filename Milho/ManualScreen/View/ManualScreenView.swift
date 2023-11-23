//
//  ManualScreenView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 13/11/23.
//

import SwiftUI

enum RectangleColorState {
    case color1
    case color2
    case color3
}

struct ManualScreenView: View {
    @State private var rectangleColorState: RectangleColorState = .color1
    @State var selectedState: Int = 0
    var image: UIImage?
    var colors: [Color]
    
    var body: some View {
        List {
                Section {
                    ImageComparisonTableCell(selectedState: $selectedState, colors: colors)
                }
                .listRowSeparator(.hidden)
                
                Section(content: {
                    TemperatureView(onTemperatureChange: { newColorState in
                        rectangleColorState = newColorState
                    }, selectedState: $selectedState)
                    
                }, header: {
                    Text("Selecione a temperatura")
                    
                }, footer: {
                    Text("Saiba qual é o subtom mais adequado para sua pele. Alterne entre as temperaturas quente, frio e neutro para descobrir.")
                })
        }
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
        .listSectionSpacing(4)
    }
}

#Preview {
    ManualScreenView(image: UIImage(named: "shoeLoading"), colors: [.black, .orange])
}
