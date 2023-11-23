//
//  ImageComparisonViewCell.swift
//  Milho
//
//  Created by Ana Elisa Lima on 21/11/23.
//

import SwiftUI

struct ImageComparisonTableCell: View {
    @State private var rectangleColorState: RectangleColorState = .color1
    @Binding var selectedState: Int
    var colors: [Color]
    var image: UIImage?
    
    var body: some View {
        ZStack {
            Image(.shoeLoading)
                .frame(height: UIScreen.main.bounds.height * 0.27)
            
            VStack(alignment: .center, spacing: 0, content: {
                Spacer()
                
                switch selectedState {
                case 0:
                    Rectangle()
                        .fill(colors[0])
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 12)

                case 1:
                    Rectangle()
                        .fill(colors[1])
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 12)

                case 2:
                    Rectangle()
                        .fill(LinearGradient(colors:[colors[0], colors[1]] , startPoint: UnitPoint(x: -0.06, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5)))
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 12)

                default:
                    Rectangle()
                        .fill(colors[0])
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 12)
                }
            })
        }
        .mask {
            RoundedRectangle(cornerSize: CGSize(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40))
        }
        .frame(maxWidth: .infinity)
    }
    private var rectangleColor: any ShapeStyle {
            switch rectangleColorState {
            case .color1:
                return colors[0]
            case .color2:
                return colors[1]
            case .color3:
                return LinearGradient(
                    stops: [
                      Gradient.Stop(color: colors[0], location: 0.00),
                      Gradient.Stop(color: colors[1], location: 1.00),
                    ],
                    startPoint: UnitPoint(x: -0.06, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)
                )
           }
     }
}
