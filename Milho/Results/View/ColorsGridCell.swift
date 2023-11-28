
//  Created by Anderson  Vulto on 21/11/23.
//

import SwiftUI

struct ColorsGridCell: View {
    
    @State private var show = false
    
    var colors: [HexColor]
    
    let columns = Array(repeating: GridItem(), count: 6)
    
    var body: some View {
   
        VStack {
            VStack {
                if !show {                      // show = (show more : show less) variable
                    
                    // if disabled evaluate colors.count (number of colors inside a HexColor array)
                    if colors.count <= 6 {
                        let index = colors.count
                        LazyVGrid(columns: columns, content: {      // load view with all colors
                            ForEach (0 ..< index, id: \.self) {color in
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(Color(hex: colors[color].hexCode))
                                    .padding(.top)
                                    //.padding(.bottom)
                            }
                        })
                    }
                    else {
                        let index = 6
                        LazyVGrid(columns: columns, content: {      // load view with all colors
                            ForEach (0 ..< index, id: \.self) {color in
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(Color(hex: colors[color].hexCode))
                                    .padding(.top)
                                    .padding(.bottom)
                            }
                        })
                    }
                // if show == true
                } else {
                    LazyVGrid(columns: columns, spacing: 8, content: {      // load view with all colors
                        ForEach (colors, id: \.self) {color in
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 44, height: 44)
                                .foregroundStyle(Color(hex: color.hexCode))
                                .padding(.top)
                                //.padding(.bottom)
                        }
                    })
                    //.padding()
                }
                
                if colors.count > 6 {   //button show more : show less appears if the number of colors is bigger than six
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            show.toggle()
                        }, label: {
                            Text(show ? "mostrar menos" : "mostrar mais")
                                .foregroundColor(.accentColor)
                                .font(.caption.lowercaseSmallCaps())
                                .animation(nil, value: show)
                        })
                        .buttonStyle(.plain)
                    }
                }
            }
            
        Spacer()
        }
    }
    
}

let idealColors = paletteList[2].idealColors
let neutralColors = paletteList[2].neutralColors
let accessoriesColors = paletteList[2].accessoriesColors


#Preview {
    VStack {
        ColorsGridCell(colors: idealColors)
        ColorsGridCell(colors: neutralColors)
        ColorsGridCell(colors: accessoriesColors)
    }
}
