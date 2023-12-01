//
//  QuizImageCell.swift
//  Milho
//
//  Created by Anderson  Vulto on 30/11/23.
//

import SwiftUI

struct SingleImageQuizCell: View {
    
    @State var desc: String?
    @State var img: String
    @State var enable: Bool = false
    
    var body: some View {
            Button(action: {
                enable.toggle()
            }, label: {
                
                if !enable {
                    VStack {
                        Text(desc ?? "")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 24)
                        Image(img)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom)
                    }
                    .overlay (
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(hex: "ADADAD"), lineWidth: 2)
                    )
                    .background(.white)
                    .mask(RoundedRectangle(cornerRadius: 12))
                    .padding(24)
                    
                }
                else {
                    VStack {
                        Text(desc ?? "")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 24)
                        Image(img)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom)
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

//#Preview {
//    SingleImageQuizCell(desc: "Ousadas e chamativas (animal print, coloridas, chevron)", img: "estampa1")
//}
