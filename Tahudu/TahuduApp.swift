//
//  TahuduApp.swift
//  Tahudu
//

import SwiftUI

@main
struct TahuduApp: App {
    @State private var container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            TahuduTabView().environmentObject(container)
        }
    }
}
