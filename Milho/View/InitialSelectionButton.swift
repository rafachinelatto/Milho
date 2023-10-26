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
            ZStack {
                Rectangle()
                    .frame(width: 380, height: 480, alignment: .center)
                    .foregroundColor(.black)
            
                VStack(alignment: .center, content: {
                    Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 60))
                    
                Text("Pick an image to process")
                    .foregroundColor(.white)
                    .padding()
                })
            }
        })
    }
}

#Preview {
    InitialSelectButton(showActionSheet: .constant(false))
}
