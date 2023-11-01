//
//  PersonalColorTestChooserView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColorTestChooserView: View {
    
    @State private var isImageTypeSelectionActive = false
    
    var body: some View {
        VStack {
            NavigationLink {
                ImageTypeSelection()
            } label: {
                Text("Teste automático")
            }
            .buttonStyle(.bordered)

        }
        .navigationTitle("Coloração pessoal")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}
