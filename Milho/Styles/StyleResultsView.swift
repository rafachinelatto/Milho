//
//  StyleResultsView.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct StyleResultsView: View {
    var body: some View {
        List {
            Section("seu estilo principal") {
                VStack {
                    Image(.tradicionalStyle)
                    HStack {
                        Text("Tradicional")
                            .font(.title2)
                        Spacer()
                    }
                    Text("Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
                        .font(.body)
                }.padding()
            }
            Section("seus estilos secundários") {
                VStack {
                    Image(.tradicionalStyle)
                    HStack {
                        Text("Tradicional")
                            .font(.title2)
                        Spacer()
                    }
                    Text("Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
                        .font(.body)
                }.padding()
                VStack {
                    Image(.tradicionalStyle)
                    HStack {
                        Text("Tradicional")
                            .font(.title2)
                        Spacer()
                    }
                        
                    Text("Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
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
