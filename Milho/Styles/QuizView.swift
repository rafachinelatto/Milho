//
//  QuizView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct QuizView: View {
    
    @State private var showResult: Bool = false
    
    @State private var question: Int = 0
    
    @State private var showingSheet: Bool = false
    
    @State private var currentTab: [String] = ["Default", "Default"]
    
    let questions = [q1, q2, q3, q4, q5, q6, q7, q8, q9]
    let ask = [
        "Como você prefere as estampas nas suas roupas?",
        "Qual paleta de cores você prefere em suas roupas?",
        "Como são seus hábitos de consumo de roupas?",
        "O que você mais procura através da moda?",
        "Com qual dessas imagens você mais se identifica?",
        "Como você gastaria 1000 reais em roupas?",
        "Com base nas palavras abaixo, com quais seus amigos te descreveriam?",
        "Quais dessas atividades fazem parte do seu dia a dia?",
        "Como você costuma consumir arte, como música e filmes?"
    ]
    
    var body: some View {
        
        VStack {
            
            //Spacer()
            
            VStack(spacing: 24) {
                Text("Pergunta \(question + 1)/9")
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                
                Text(ask[question])
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
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
                
                if question == 8 {
                    showResult = true
                }
                
            }, label: {
                
                if question != 8 {
                    Text("Próxima")
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height/30)
                }
                else {
                    Text("Finalizar")
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height/30)
                }
            })
            .buttonStyle(.borderedProminent)
            
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
                .presentationDetents([.large])
        })
        .navigationDestination(isPresented: $showResult) {
            StyleFeedbackView()
                .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    QuizView()
}

