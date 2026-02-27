//
//  MiBancaApp.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

@main
struct MiBancaApp: App {
    @StateObject private var session = SessionManager()
    var test: String = "Only testing"
    var body: some Scene {

        WindowGroup {
            RootView()
                .environmentObject(session)
        }
    }
}
