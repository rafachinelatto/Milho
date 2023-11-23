//
//  ColorsData.swift
//  Milho
//
//  Created by Ana Elisa Lima on 17/11/23.
//

import SwiftUI

struct Colors: Identifiable {
    
    var id = UUID()
    var colors: [Color]
    
    init(id: UUID = UUID(), colors: [Color]) {
        self.id = id
        self.colors = colors
    }
}

var colorsArray: [Colors] = [
    
    Colors(colors: [Color(red: 0.6, green: 0.8, blue: 0.2),
    Color(red: 0.05, green: 0.6, blue: 0.73)]),
    
    Colors(colors: [Color(red: 1, green: 1,blue: 0.94),
    Color.white]),
    
    Colors(colors: [Color(red: 1, green: 0.65, blue: 0),
     Color(red: 0.99, green: 0.06, blue: 0.75)]),
    
    Colors(colors: [Color(red: 1, green: 0.33, blue: 0.29),
     Color(red: 0.5, green: 0, blue: 0.13)]),
    
    Colors(colors: [Color(red: 0.36, green: 0.25, blue: 0.2),
     Color.black])
    ]
