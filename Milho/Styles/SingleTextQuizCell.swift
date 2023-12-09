//
//  SingleTextQuizCell.swift
//  Milho
//
//  Created by Anderson  Vulto on 07/12/23.
//

import SwiftUI

struct SingleTextQuizCell: View {
    
    @State var desc: String
    @State var enable: Bool = false
    
    var body: some View {
        Button(action: {
            enable.toggle()
        }, label: {
            
            if !enable {
                
                VStack {
                   
                    HStack {
                        Text(desc)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                .padding(8)
                
                .frame(width: UIScreen.main.bounds.width/3.5, height: UIScreen.main.bounds.height/6)
                .overlay (
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "ADADAD"), lineWidth: 2)
                )
                .background(.white)
                .mask(RoundedRectangle(cornerRadius: 12))
                //.padding(24)
                
            }
            else {
                VStack {
                   
                    Text(desc)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                }
                .overlay (
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.accentColor, lineWidth: 2)
                )
                .background(.white)
                .mask(RoundedRectangle(cornerRadius: 12))
                .padding(24)
            }
            
        })
        .buttonStyle(.plain)
        }
}

#Preview {
    SingleTextQuizCell(desc: "Sempre aproveito para comprar nas promoções")
}
