//
//  ContentView.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 13/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show:Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            
            QuoteView(show:Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
            
            QuoteView(show:Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label(Constants.ecName, systemImage: "car")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
