//
//  AfriSureApp.swift
//  AfriSure
//
//  Created by iosdevelopment on 02/01/24.
//

import SwiftUI
import FirebaseCore


@main
struct AfriSureApp: App {
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
    @StateObject private var locationManagerDelegate = LocationManagerDelegate()
    @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, .init(identifier: Extensions.selectedLanguage))
                .onAppear {
                    deviceLatitude = String(format: "%.6f", locationManagerDelegate.latitude)
                    devicelongitude = String(format: "%.6f", locationManagerDelegate.longitude)
                }
                .overlay {
                    !networkMonitor.isConnected ? ErrorView() : nil
                }
        }
        
    }
}
