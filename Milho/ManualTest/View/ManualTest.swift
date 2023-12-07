//
//  ManualTest.swift
//  Milho
//
//  Created by Ana Elisa Lima on 16/11/23.
//

import SwiftUI

struct ManualTest: View {
    
    @State private var manualCurrentTab = 1
    @State private var completeManualTest = false
    @AppStorage("isManual") var isManual: Bool?
    var image: UIImage
    
    var body: some View {
        VStack {
            TabView (selection: $manualCurrentTab) {
                ForEach (0..<5) {index in
                    ManualScreenView(image: image, colors: colorsArray[index].colors)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onChange(of: manualCurrentTab) {
                if manualCurrentTab == 4 {
                    completeManualTest = true
                }
            }
            
            Button {
            isManual = false
            } label: {
                Text("Finalizar teste manual")
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 25)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!completeManualTest)
            .padding()
            
        }
        .background(Color(.secondarySystemBackground))
    }
}


#Preview {
    ManualTest(image: UIImage(named: "eu") ?? UIImage())
}
