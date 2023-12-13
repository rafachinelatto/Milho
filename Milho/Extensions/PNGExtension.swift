//
//  PNGExtension.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 13/12/23.
//

import Foundation
import SwiftUI

struct PNG {
    private let data: Data
    
    init(_ data: Data) {
        self.data = data
    }
}

extension PNG: Transferable {
    
    static var transferRepresentation: some TransferRepresentation {
        
        DataRepresentation<PNG>(contentType: .png) { imageData in
            imageData.data
        } importing: { data in
            PNG(data)
        }
    }
}
