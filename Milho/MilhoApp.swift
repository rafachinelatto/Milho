//
//  MilhoApp.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 03/10/23.
//

import SwiftUI

@main
struct MilhoApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @AppStorage("result") var result: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                PersonalColoring()
            } else {
                TabBar()
            }
            
            }
        }
    }
