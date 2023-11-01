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
                    .frame(height: UIScreen.main.bounds.height/10)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            NavigationLink {
                ImageTypeSelection()
            } label: {
                Text("Teste manual")
                    .frame(height: UIScreen.main.bounds.height/10)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .navigationTitle("Coloração pessoal")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        
    }
}
