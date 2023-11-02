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
            
            Spacer(minLength: 32)
            
            NavigationLink {
                ImageTypeSelection()
            } label: {
                VStack {
                    Text("Realizar teste automático")
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    //Place an Image() instead of a Spacer with the illustration vector planed
                    
                    Text("Deixe que a visão computacional te forneça sua paleta de cores!")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .frame(height: UIScreen.main.bounds.height/3)
            }
            .buttonStyle(.bordered)
            
            Spacer(minLength: 32)
            
            NavigationLink {
                ImageTypeSelection()
            } label: {
                VStack {
                    Text("Realizar teste manual")
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    //Place an Image() instead of a Spacer with the illustration vector planed
                    
                    Text("Escolha as cores que mais combinam com você e deixa que a gente faz o resto.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .frame(height: UIScreen.main.bounds.height/3)
            }
            .buttonStyle(.bordered)
            
            
            Spacer(minLength: 32)
        }
        .navigationTitle("Coloração pessoal")
        .navigationBarTitleDisplayMode(.inline)
        .padding(32)
        
    }
}
