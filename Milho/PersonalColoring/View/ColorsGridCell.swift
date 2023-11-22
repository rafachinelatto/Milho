
//  Created by Anderson  Vulto on 21/11/23.
//

import SwiftUI

struct ColorsGridCell: View {
    
    @State private var show = false
    
    let colors1 = ["F9E585", "F18B63", "F18B80", "71C661", "4FB9E3", "C79AE5", "FCF79D", "F6BF7C", "F4C0C6", "ED6362", "F195AF", "B0E19C", "4AAD81", "7BE1D2", "46A3A4", "CDE0FB", "A7BDEF", "A0D9F6", "B9B6E5", "7B64C1", "583C9B", "975DA9"]
    
    var colors: [String]
    
    let columns = Array(repeating: GridItem(), count: 6)
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundStyle(.gray)
            VStack {
                VStack {
                    if show == false {
                        let index = 6
                        LazyVGrid(columns: columns, content: {
                            ForEach (0..<index) {color in
                                Rectangle()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(Color(hex: colors[color]))
                                    .padding(.top)
                                    .padding(.bottom)
                                    .clipShape(Circle())
                            }
                        })
                        .padding(.leading)
                        .padding(.trailing)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16, content: {
                            ForEach (colors, id: \.self) {color in
                                Rectangle()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(Color(hex: color))
                                    .clipShape(Circle())
                            }
                        })
                        .padding()
                    }
                    
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
                    .padding(.trailing)
                    .padding(.bottom)
                }
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            Spacer()
            }
            
            .padding()
        }
        
    }
}

let colors1 = ["F9E585", "F18B63", "F18B80", "71C661", "4FB9E3", "C79AE5", "FCF79D", "F6BF7C", "F4C0C6", "ED6362", "F195AF", "B0E19C", "4AAD81", "7BE1D2", "46A3A4", "CDE0FB", "A7BDEF", "A0D9F6", "B9B6E5", "7B64C1", "583C9B", "975DA9"]

#Preview {
    ColorsGridCell(colors: colors1)
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
