//
//  week13_0_Local_hostApp.swift
//  week13.0 Local host
//
//  Created by Apple  on 06/12/22.
//

import SwiftUI

@main
struct week13_0_Local_hostApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
            
        }
    }
}
