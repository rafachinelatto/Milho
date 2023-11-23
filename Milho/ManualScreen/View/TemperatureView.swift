//
//  TemperatureView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 13/11/23.
//

import SwiftUI

struct TemperatureView: View {
    var onTemperatureChange: (RectangleColorState) -> Void
    @Binding var selectedState: Int
    @State var hotSelected: Bool = true
    @State var coldSelected: Bool = false
    @State var neutralSelected: Bool = false
    
    @State var selected = [true,false,false]
    
    var icons = ["flame", "snowflake", "sleep.circle"]
    var names = ["Quente", "Frio", "Neutro"]
    
    var body: some View {
        HStack {
            VStack (alignment: .center) {
                VStack {
                    Image(systemName: icons[0])
                        .font(.system(size: 30))
                    
                    Text(names[0])
                        .font(Font.custom("SF Pro Rounded", size: 15))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom)
                .symbolVariant(hotSelected ? .fill : .none)
                .foregroundColor(hotSelected ? .accent : Color(red: 0.27, green: 0.27, blue: 0.27))
                
                Toggle("", isOn: $hotSelected)
                    .labelsHidden()
                    .toggleStyle(CheckboxStyle())
                    .font(.title)
                    .onChange(of: hotSelected) { (oldValue, newValue) in
                        if newValue {
                            coldSelected = false
                            neutralSelected = false
                            onTemperatureChange(.color1)
                            selectedState = 0
                        }
                  }
            }
            
            Spacer()
            
            VStack (alignment: .center) {
                VStack {
                    Image(systemName: icons[1])
                        .font(.system(size: 30))
                    
                    Text(names[1])
                        .font(Font.custom("SF Pro Rounded", size: 15))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom)
                .symbolVariant(coldSelected ? .fill : .none)
                .foregroundColor(coldSelected ? .accent : Color(red: 0.27, green: 0.27, blue: 0.27))
                
                Toggle("", isOn: $coldSelected)
                    .labelsHidden()
                    .toggleStyle(CheckboxStyle())
                    .font(.title)
                    .onChange(of: coldSelected) { (oldValue, newValue) in
                        if newValue {
                            hotSelected = false
                            neutralSelected = false
                            onTemperatureChange(.color2)
                            selectedState = 1
                        }
                  }
            }
            
            Spacer()
            
            VStack (alignment: .center) {
                VStack {
                    Image(systemName: icons[2])
                        .font(.system(size: 30))
                    
                    Text(names[2])
                        .font(Font.custom("SF Pro Rounded", size: 15))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom)
                .symbolVariant(neutralSelected ? .fill : .none)
                .foregroundColor(neutralSelected ? .accent : Color(red: 0.27, green: 0.27, blue: 0.27))
                
                Toggle("", isOn: $neutralSelected)
                    .labelsHidden()
                    .toggleStyle(CheckboxStyle())
                    .font(.title)
                    .onChange(of: neutralSelected) { (oldValue, newValue) in
                        if newValue {
                            coldSelected = false
                            hotSelected = false
                            onTemperatureChange(.color3)
                            selectedState = 2
                        }
                    }
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
    
#Preview {
 TemperatureView(onTemperatureChange: { newColorState in
    }, selectedState: .constant(0))
}
