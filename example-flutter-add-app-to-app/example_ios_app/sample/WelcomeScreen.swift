//
//  WelcomeScreen.swift
//  sample
//
//  Created by huy on 14/01/2023.
//

import Foundation
import SwiftUI
import Flutter
import FlutterPluginRegistrant
class FlutterDependencies: ObservableObject {
  let flutterEngine = FlutterEngine(name: "com.sample.my_flutter.engine")
  init(){
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run()
    // Connects plugins with iOS platform code to this app.
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
  }
}
struct WelcomeScreenView : View {
    @StateObject var flutterDependencies = FlutterDependencies()
    var body: some View{
        NavigationView{
            ZStack{
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Welcome screen")
                    Spacer()
                    Button() {
                       
                    }label: {
                        NavigationLink(destination: LoginScreen().environmentObject(flutterDependencies)) {
                            Text("Get started")
                                .frame(maxWidth: .infinity)
                        }}
                    Spacer()
                    
                }
            }
        }
    }
}
struct WelcomeScreenView_Previews : PreviewProvider {
    static var previews: some View{
        WelcomeScreenView()
    }
}
