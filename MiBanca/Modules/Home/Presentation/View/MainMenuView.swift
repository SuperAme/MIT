//
//  MainMenuView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct MainMenuView: View {
    @StateObject var viewModel = MainMenuViewModel()

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Mis tarjetas", destination: Text("Mis tarjetas"))
                NavigationLink("Pagar", destination: Text("Pagar"))
                NavigationLink("Mis movimientos", destination: Text("Mis movimientos"))

                Button("Cerrar sesión") {
                    viewModel.logout()
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Menú Principal")
            .fullScreenCover(isPresented: $viewModel.isLoggedOut) {
                LoginView()
            }
        }
    }
}
