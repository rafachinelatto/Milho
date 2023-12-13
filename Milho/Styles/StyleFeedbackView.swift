//
//  StyleFeedbackView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct StyleFeedbackView: View {
    
    let style = ["Tradicional", "Natural", "Contemporaneo", "Romantico", "Dramatico", "Sexy", "Criativo"]
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 48) {
                Image(.styleFeedback)
                    .scaledToFill()
                
                //Spacer()
                
                VStack (spacing: 48){
                    Text("Agora você está no estilo! E ele é predominantemente")
                        .multilineTextAlignment(.center)
                    //Spacer()
                    Text(style[2])
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                NavigationLink {
                    StyleResultsView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Ver mais detalhes")
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height/25)
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    StyleFeedbackView()
}
