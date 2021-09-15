//
//  ContentView.swift
//  Challenge1
//
//  Created by Quinn McHenry on 8/26/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var bedtime: Date
    @Binding var wakeUp: Date

    var body: some View {
        VStack {
            Text("Next Wake Up Only")
                .font(.largeTitle)
                .bold()
                .padding()

            Card {
                VStack {
                    HStack(spacing: 36) {
                        TimeGroup(header: "BEDTIME", date: bedtime)
                        TimeGroup(header: "WAKE UP", date: wakeUp)
                    }
                    .font(.callout)
                    .padding(.top)
                    Dial()
                        .padding(.horizontal, 10)
                        .aspectRatio(1, contentMode: .fit)

                    Text(duration)
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color("primary"))
                    Text("This schedule meets your sleep goal.")
                        .padding(.bottom)
                }
                .foregroundColor(Color("secondary"))
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color("backgroundScene"))
    }

    var duration: String {
        let seconds = wakeUp.timeIntervalSince(bedtime)
        let hours = floor(seconds / 3600)
        let fiveMinutes = floor(seconds.truncatingRemainder(dividingBy: 3600) / 5 / 60)
        let hoursString: String? = hours == 0 ? nil : "\(Int(hours)) hr"
        let minutesString: String? = fiveMinutes == 0 ? nil : "\(Int(fiveMinutes) * 5) min"
        return [hoursString, minutesString].compactMap { $0 }.joined(separator: " ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static let scheme = ColorScheme.dark
    static var previews: some View {
        Group {
            ContentView(bedtime: .constant(Date()), wakeUp: .constant(Date(timeIntervalSinceNow: 29100)))
                .preferredColorScheme(scheme)
            Image("example")
                .resizable()
                .scaledToFit()
                .preferredColorScheme(scheme)
        }
    }
}
