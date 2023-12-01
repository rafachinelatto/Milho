//
//  StylesEmptyStateView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct StylesEmptyStateView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationStack {
            
                VStack {
                    VStack {
                        Spacer()
                        Text("Você ainda não realizou o teste de estilos")
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    NavigationLink {
                        QuizView()
                    } label: {
                        Text("Começar o questionário")
                            .frame(height: UIScreen.main.bounds.height/21)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .navigationTitle("Estilos")
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
                        Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            Image(systemName: "info.circle")
                        })
                    }
                }
                .padding()
                .sheet(isPresented: $showingSheet, content: {
                    InfoSheetView()
                        .presentationDetents([.medium])
                })
            }
        }
    }

#Preview {
    StylesEmptyStateView()
    //InfoSheetView()
}
