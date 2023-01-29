//
//  LoginScreen.swift
//  sample
//
//  Created by huy on 14/01/2023.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant



struct LoginScreen: View {
    @EnvironmentObject var flutterDependencies: FlutterDependencies

    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationView{
            VStack{
                Text("Login Screen")
                TextField("Email", text: $email).font(.title3).padding().frame(maxWidth : .infinity).background(Color.white).cornerRadius(15).shadow(color: Color.black, radius: 50, x: 0, y: 16).padding(.vertical)
                SecureField("Password", text: $password).font(.title3).padding().frame(maxWidth : .infinity).background(Color.white).cornerRadius(15).shadow(color: Color.black, radius: 50, x: 0, y: 16).padding(.vertical)
                Button("Login", action: {
                    if(email == "admin@email.com" && password == "123"){
                        showFlutter()
                    }
                }).frame(width: 150, height: 50, alignment: .center)
            }
        }
        
        
    }
    func showFlutter() {
        // Get the RootViewController.
        guard
          let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
          let window = windowScene.windows.first(where: \.isKeyWindow),
          let rootViewController = window.rootViewController
        else { return }

        // Create the FlutterViewController.
        let flutterViewController = FlutterViewController(
          engine: flutterDependencies.flutterEngine,
          nibName: nil,
          bundle: nil)
        flutterViewController.modalPresentationStyle = .overCurrentContext
        flutterViewController.isViewOpaque = false

        rootViewController.present(flutterViewController, animated: true)
      }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
