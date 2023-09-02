//
//  NeoWallet.swift
//  Forge UX Demo
//
//  Created by Race Li on 2023/9/2.
//

//import SwiftUI
//
//struct LoginView: View {
//
//  @State private var wallet: Wallet?
//
//  var body: some View {
//
//    VStack {
//
//      if let wallet = wallet {
//        Text("Logged in as \(wallet.address)")
//      } else {
//
//        Button("Login") {
//          login()
//        }
//
//      }
//
//    }
//
//  }
//
//  func login() {
//
//    do {
//      // Create Neo wallet instance
//      let wallet = try Wallet(seed: nil)
//
//      // Save wallet reference
//      self.wallet = wallet
//
//    } catch {
//      print(error)
//    }
//
//  }
//
//}
//
//struct NeoWallet_Previews: PreviewProvider {
//    static var previews: some View {
//        NeoWallet()
//    }
//}
