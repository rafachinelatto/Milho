//
//  StyleResultsView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct StyleResultsView: View {
    
    let style = ["Tradicional", "Natural", "Contemporaneo", "Romantico", "Dramatico", "Sexy", "Criativo"]
    
    var body: some View {
        List {
            Section("seu estilo principal") {
                VStack {
                    Image(.contemporaneoStyle)
                    HStack {
                        Text(style[2])
                            .font(.title2)
                        Spacer()
                    }
                    Text("Este estilo é moderno e atualizado. Pessoas com estilo contemporâneo gostam de seguir as tendências da moda, mas também adaptam as peças ao seu gosto pessoal. Optam por roupas versáteis, combinando elementos clássicos e modernos para criar um visual equilibrado e atual.")
                        .font(.body)
                }.padding()
            }
            Section("seus estilos secundários") {
                VStack {
                    Image(.dramaticoStyle)
                    HStack {
                        Text(style[4])
                            .font(.title2)
                        Spacer()
                    }
                    Text("Este estilo é ousado, impactante e marcante. Pessoas com estilo dramático optam por roupas com cortes arrojados, cores intensas, estampas audaciosas e acessórios chamativos. Valorizam peças que causem uma impressão forte e marcante.")
                        .font(.body)
                }.padding()
                VStack {
                    Image(.romanticoStyle)
                    HStack {
                        Text(style[3])
                            .font(.title2)
                        Spacer()
                    }
                        
                    Text("O estilo romântico é delicado, feminino e cheio de detalhes. Pessoas que se identificam com esse estilo preferem tecidos leves, cores suaves, estampas florais, rendas e babados. Valorizam peças que expressem uma aparência suave e encantadora.")
                        .font(.body)
                }.padding()
            }
        }
        .navigationTitle("Seu estilo")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    StyleResultsView()
}
