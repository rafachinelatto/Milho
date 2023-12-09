//
//  QuestionView.swift
//  Milho
//
//  Created by Anderson  Vulto on 07/12/23.
//

import SwiftUI

struct QuestionView: View {
    
    @Binding var number: Int
    
    let questions = [q1, q2, q3, q4, q5, q6, q7, q8, q9]
    
    let columns = Array(repeating: GridItem(), count: 3)
    
    var body: some View {
        
        if number == 0 || number == 1 {
            
            LazyVGrid(columns: columns, content: {
                ForEach(Array(questions[number].enumerated()), id: \.1) { index, qItem in
                    SingleImageQuizCell(desc: qItem[1], img: qItem[0])
                        .tag(qItem)
                }
            })
            
        }
        else if number == 3 || number == 5 {
            LazyVGrid(columns: columns, content: {
                ForEach(Array(questions[number].enumerated()), id: \.1) { index, qItem in
                    SingleTextQuizCell(desc: qItem[0])
                        .tag(qItem)
                }
            })
        }
        else if number == 4 {
            LazyVGrid(columns: columns, content: {
                ForEach(Array(questions[number].enumerated()), id: \.1) { index, qItem in
                    SingleImageQuizCell(img: qItem[0])
                        .tag(qItem)
                }
            })
        }
        else {
            LazyVGrid(columns: columns, content: {
                ForEach(Array(questions[number].enumerated()), id: \.1) { index, qItem in
                    SingleTextQuizCell(desc: qItem[0])
                        .tag(qItem)
                }
            })
        }
        
    }
}
