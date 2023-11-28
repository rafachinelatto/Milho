
//  Created by Anderson  Vulto on 21/11/23.
//

import SwiftUI

struct ColorsGridCell: View {
    
    @State private var show = false
    
//    let colors1 = ["F9E585", "F18B63", "F18B80", "71C661", "4FB9E3", "C79AE5", "FCF79D", "F6BF7C", "F4C0C6", "ED6362", "F195AF", "B0E19C", "4AAD81", "7BE1D2", "46A3A4", "CDE0FB", "A7BDEF", "A0D9F6", "B9B6E5", "7B64C1", "583C9B", "975DA9"]
    
    var colors: [HexColor]
    
    let columns = Array(repeating: GridItem(), count: 6)
    
    var body: some View {
   
        VStack {
            VStack {
                if show == false {
                    if colors.count > 6 {
                        let index = 6
                        LazyVGrid(columns: columns, content: {
                            ForEach (0..<index) {color in
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(Color(hex: colors[color].hexCode))
                                    .padding(.top)
                                    .padding(.bottom)
                            }
                        })
                    } else {
                        let index = colors.count
                        LazyVGrid(columns: columns, content: {
                            ForEach (0..<index) {color in
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(Color(hex: colors[color].hexCode))
                                    .padding(.top)
                            }
                        })
                    }
                    
                    //.padding(.leading)
                    //.padding(.trailing)
                } else {
                    LazyVGrid(columns: columns, spacing: 8, content: {
                        ForEach (colors, id: \.self) {color in
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 44, height: 44)
                                .foregroundStyle(Color(color.hexCode))
                                .padding(.top)
                                //.padding(.bottom)
                        }
                    })
                    //.padding()
                }
                
                if colors.count > 6 {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text(show ? "mostrar menos" : "mostrar mais")
                                .foregroundColor(.accentColor)
                                .font(.caption.lowercaseSmallCaps())
                                .animation(nil, value: show)
                        }
                    })
                }
                
                //.padding(.trailing)
                //.padding(.bottom)
            }
            //.background()
            
        Spacer()
        }
            
            //.padding()
    }
    
}

let colors1 = ["F9E585", "F18B63", "F18B80", "71C661", "4FB9E3", "C79AE5", "FCF79D", "F6BF7C", "F4C0C6", "ED6362", "F195AF", "B0E19C", "4AAD81", "7BE1D2", "46A3A4", "CDE0FB", "A7BDEF", "A0D9F6", "B9B6E5", "7B64C1", "583C9B", "975DA9"]

//#Preview {
//    ColorsGridCell()
//}
