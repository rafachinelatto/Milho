//
//  QuizView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct QuizView: View {
    
    @State private var question: Int = 0
    
    @State private var showingSheet: Bool = false
    
    @State private var currentTab: [String] = ["Default", "Default"]
    
    let questions = [q1, q2, q3, q4, q5, q6, q7, q8, q9]    
    
    var body: some View {
        VStack {
            
            //Spacer()
            
            VStack(spacing: 24) {
                Text("Pergunta \(question + 1)/9")
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                
                Text("Como você prefere as estampas nas suas roupas?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            QuestionView(number: $question)
            
            Spacer()
            
            Button(action: {
                if question < 9 {
                    question += 1
                }
                else {
                    print(question)
                }
            }, label: {
                Text("Próxima pergunta")
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height/30)
            })
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationTitle("Teste de Estilos")
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    QuizView()
}

