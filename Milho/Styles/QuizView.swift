//
//  QuizView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct QuizView: View {
    
    @State private var question: Int = 1
    
    @State private var showingSheet: Bool = false
    
    @State private var currentTab: [String] = ["Default", "Default"]
    
    let q1 = [["estampa1", "Ousadas e chamativas (animal print, coloridas, chevron)"],
            ["estampa2","Suaves e delicadas (florais suaves, rendas, poás)"],
            ["estampa3","Clássicas (xadrez, listrado, herringbone)"],
            ["estampa4","Sem estampas ou minimalistas"],
            ["estampa5","Vario entre estampas e peças sem estampas, dependendo da ocasião"],
            ["estampa6","Não tenho preferência por estampas"]
            ]
    
    
    var body: some View {
        VStack {
            
            //Spacer()
            
            VStack(spacing: 24) {
                Text("Pergunta \(question)/9")
                    .font(.subheadline)
                    .foregroundStyle(Color(.secondaryLabel))
                
                Text("Como você prefere as estampas nas suas roupas?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            TabView(selection: $currentTab) {
                ForEach(Array(q1.enumerated()), id: \.1) { index, q1Item in
                    SingleImageQuizCell(desc: q1Item[1], img: q1Item[0])
                        .tag(q1Item)
                }
            }
            .frame(height: UIScreen.main.bounds.height/2)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Spacer()
            
            Button(action: {
                if question < 9 {
                    question += 1
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

