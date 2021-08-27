//
//  ContentView.swift
//  Challenge1
//
//  Created by Quinn McHenry on 8/26/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Next Wake Up Only")
                .font(.largeTitle)
                .bold()
                .padding()

            Card {
                VStack {
                    HStack(spacing: 36) {
                        Text("BEDTIME")
                            .bold()
                        Text("WAKE UP")
                            .bold()
                    }
                    .foregroundColor(Color("secondary"))
                    .font(.callout)
                    .padding(.top)
                    Circle()
                        .scaledToFit()
                        .foregroundColor(Color("dial"))
                    .padding()
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color("backgroundScene"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static let scheme = ColorScheme.dark
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(scheme)
            Image("example")
                .resizable()
                .scaledToFit()
                .preferredColorScheme(scheme)
        }
    }
}
