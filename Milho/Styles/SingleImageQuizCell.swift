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
                       
                        HStack {
                            Text(desc ?? "")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Image(img)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
//                            .padding(.horizontal, 8)
//                            .padding(.bottom)
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
                       
                        HStack {
                            Text(desc ?? "")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Image(img)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
//                            .padding(.horizontal, 8)
//                            .padding(.bottom)
                    }
                    .padding(8)
                    
                    .frame(width: UIScreen.main.bounds.width/3.5, height: UIScreen.main.bounds.height/6)
                    .overlay (
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                    .background(.white)
                    .mask(RoundedRectangle(cornerRadius: 12))
                }
                
            })
            .buttonStyle(.plain)
            }

    }

#Preview {
    SingleImageQuizCell(desc: "Não tenho preferências", img: "estampa6")
}
