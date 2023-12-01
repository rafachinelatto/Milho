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
            Text("Norem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque.")
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding()

    }
}

#Preview {
    InfoSheetView()
}
