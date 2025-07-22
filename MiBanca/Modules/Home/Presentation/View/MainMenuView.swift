//
//  MainMenuView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject var viewModel = MainMenuViewModel()

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Mis tarjetas", destination: MyCardsView())
                NavigationLink("Pagar", destination: PaymentView())
                NavigationLink("Mis movimientos", destination: Text("Movements"))

                Button("Cerrar sesión") {
                    viewModel.logout()
                    session.isLoggedIn = false
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Menú Principal")
            .navigationBarBackButtonHidden(true)
        }
    }
}
