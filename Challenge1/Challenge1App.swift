//
//  Challenge1App.swift
//  Challenge1
//
//  Created by Quinn McHenry on 8/26/21.
//

import SwiftUI

@main
struct Challenge1App: App {
    @State private var bedtime = Date()
    @State private var wakeUp = Date(timeIntervalSinceNow: 42000)

    var body: some Scene {
        WindowGroup {
            ContentView(bedtime: $bedtime, wakeUp: $wakeUp)
        }
    }
}
