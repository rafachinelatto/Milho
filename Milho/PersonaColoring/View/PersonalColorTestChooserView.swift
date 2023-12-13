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
        
        VStack (spacing: 48){
            
            NavigationLink {
                ImageTypeSelection(isManualTest: false)
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                    VStack (spacing: 8){
                        Image("testeAutomatico")
                            .scaledToFill()
                            .frame(alignment: .trailing)
                        
                        HStack {
                            Text("Realizar teste automático")
                                .foregroundStyle(.primary)
                                .font(Font.custom("SF Pro Rounded", size: 19))
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Deixe que a visão computacional te forneça sua paleta de cores!")
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                                .font(Font.custom("SF Pro Rounded", size: 16))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    .padding()
                    
                }
                
            }
            
            NavigationLink {
                ImageTypeSelection(isManualTest: true)
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                        .foregroundColor(Color(uiColor: UIColor.secondarySystemBackground))
                    VStack (spacing: 8){
                        Image("testeManual")
                            .scaledToFill()
                            .frame(alignment: .trailing)
                        
                        HStack {
                            Text("Realizar teste manual")
                                .foregroundStyle(.primary)
                                .font(.system(size: 19))
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Escolha as cores que mais combinam com você e deixa que a gente faz o resto.")
                                .foregroundStyle(.secondary)
                                .fontWeight(.regular)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    .padding()
                    
                }
                
            }
            

        }
        .navigationTitle("Coloração pessoal")
        .navigationBarTitleDisplayMode(.inline)
        .padding(41)
        
        
    }
    
}


//#Preview {
//    PersonalColorTestChooserView(showManualTest: .constant(false))
//}
