//
//  InitialSelectionButton.swift
//  Milho
//
//  Created by Ana Elisa Lima on 26/10/23.
//

import SwiftUI

struct InitialSelectButton: View {
    @Binding var showActionSheet: Bool
    
    var body: some View {
        
        VStack {
            Button(action: {
                self.showActionSheet.toggle()
            }, label: {
                Image(systemName: "camera.fill")
                    .font(.system(size: UIScreen.main.bounds.width/6))
            })
            .foregroundStyle(.accent)
            .buttonStyle(.bordered)
            
            Text("Tire uma foto ou selecione da galeria para começar seu teste de coloração pessoal.")
                .foregroundStyle(.gray)
                .padding()
        }
    }
}

#Preview {
    InitialSelectButton(showActionSheet: .constant(false))
}
