
// PaletaView.swift
// Testando2
//
// Created by Bruna Lacerda on 10/11/23.
//
import SwiftUI
// .previewDisplayName("Insetgroup")
struct ResultsListView: View {
    
    let accessories = ["E0D8DD", "F9E193"]
    
    let neutral = ["FBF7E2", "F3D5B7", "F9E8D6", "CFC2B2", "958B89", "8C6852"]
    
    let colors = ["F9E585", "F18B63", "F18B80", "71C661", "4FB9E3", "C79AE5", "FCF79D", "F6BF7C", "F4C0C6", "ED6362", "F195AF", "B0E19C", "4AAD81", "7BE1D2", "46A3A4", "CDE0FB", "A7BDEF", "A0D9F6", "B9B6E5", "7B64C1", "583C9B", "975DA9"]
    
    
    var body: some View {
        
        
            Section {
                VStack (spacing: 24) {
                    Image("primaveraClara")
                        .padding(.top)
                    
                    Text("Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .font(.system(size: 17))
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .frame(alignment: .center)
            }
            
            .listRowBackground(Color(.clear))
            //.padding(.horizontal)
            .listRowSeparator(.hidden)
            
            Section ("MELHORES CORES") {
                ColorsGridCell(colors: colors)
            }
            //.padding(.horizontal)
            
            Section ("TONS NEUTROS") {
                ColorsGridCell(colors: neutral)
            }
            //.padding(.horizontal)
            
            Section ("ACESSÓRIOS") {
                ColorsGridCell(colors: accessories)
            }
        
        
        
    }
}


#Preview {
    ResultsListView()
}
