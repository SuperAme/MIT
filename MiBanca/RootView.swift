//
//  RootView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        NavigationView {
            if session.isLoggedIn {
                MainMenuView()
            } else {
                LoginView()
            }
        }
    }
}
