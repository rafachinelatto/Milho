//
//  File.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct InfoSheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack (spacing: 24) {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("OK")
//                        Image(systemName: "x.circle.fill")
//                            .foregroundStyle(.gray)
//                            .scaledToFill()
                    }
                }
                HStack {
                    Text("Sobre os estilos")
                        .font(.title2)
                        .foregroundStyle(.primary)
                    Spacer()
                }
            }
            Text("""
                 "Os sete estilos universais são um conceito criado pela estilista Alyce Parsons, que os define como sendo a base para todos os outros estilos que existem. Embora com o tempo tenham sofrido adaptações e mudanças de interpretação, continuam sendo uma ferramenta útil para ajudar as pessoas a entenderem como elas se expressam e como podem explorar ainda mais a moda.
                 Há três estilos principais: casual, tradicional e contemporâneo.  E há também quatro estilos complementares: dramático, romântico, sensual e criativo. Cada pessoa normalmente costuma combinar características de dois ou três desses estilos.
                """)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding()

    }
}

#Preview {
    InfoSheetView()
}
