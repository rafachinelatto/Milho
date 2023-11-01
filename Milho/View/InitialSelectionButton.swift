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
        Button(action: {
            self.showActionSheet.toggle()
        }, label: {
            
                VStack(alignment: .center, content: {
                    Image(systemName: "camera.fill")
                        .foregroundColor(Color("AccentColor"))
                    .font(.system(size: 60))
                    
                    Text("Pick an image to process")
                        .foregroundColor(Color("AccentColor"))
                        .padding()
                })
        })
        .buttonStyle(.bordered)
    }
}

#Preview {
    InitialSelectButton(showActionSheet: .constant(false))
}
