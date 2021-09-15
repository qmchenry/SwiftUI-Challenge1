//
//  Dial.swift
//  Challenge1
//
//  Created by Quinn McHenry on 9/14/21.
//

import SwiftUI

let ringWidth = 70.0

struct Dial: View {
    let hashes: [Hashmark] = {
        (0..<(24*4)).map { Hashmark(id: $0)}
    }()

    var body: some View {
            GeometryReader { proxy in
                ZStack(alignment: .center) {
                Circle()
                    .scaledToFit()
                    .foregroundColor(Color("dial"))
                    .padding()
                Circle()
                    .scaledToFit()
                    .foregroundColor(Color("backgroundCard"))
                    .padding(ringWidth)
                ZStack {
                    ForEach(hashes) { hash in
                        hash.path(in: proxy.size)
                            .stroke(Color("secondary"), lineWidth: 1)
                        hash.label(in: proxy.size)
                    }
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct Hashmark: Identifiable {
    let id: Int

    var isHour: Bool {
        id % 4 == 0
    }

    var hour: Int {
        id / 4
    }

    var hashLength: Double {
        isHour ? 12 : 4
    }

    var angle: Angle {
        Angle(degrees: -360.0 / 24 / 4 * Double(id))
    }

    func startPoint(in rect: CGSize, inset: Double = 0, forPath: Bool = false) -> CGSize {
        let angle = angle
        let radius = (rect.width - ringWidth * 2 - inset) / 2 * 1.0
        let x = sin(angle.radians) * radius + (forPath ? rect.width / 2.0 : 0.0)
        let y = cos(angle.radians) * radius + (forPath ? rect.height / 2.0 : 0.0)
        print("id: \(id) -> x: \(x), y: \(y)")
        return .init(width: x, height: y)
    }

    func path(in size: CGSize) -> Path {
        Path { path in
            path.move(to: CGPoint(startPoint(in: size, inset: 10, forPath: true)))
            path.addLine(to: CGPoint(startPoint(in: size, inset: 10 + hashLength, forPath: true)))
        }
    }

    @ViewBuilder
    func label(in size: CGSize) -> some View {
        if isHour && hour % 2 == 0 {
            Group {
                Text(hourCopy).font(.callout)
                + Text(hourSuffix).font(.caption2)
            }
                .foregroundColor(Color(hour % 6 == 0 ? "primary" : "secondary"))
                .offset(startPoint(in: size, inset: 48))
                .padding(.trailing, hour == 18 ? 10 : 0)
                .padding(.leading, hour == 6 ? 10 : 0)
        } else {
            EmptyView()
        }
    }

    var hourCopy: String {
        let hourRaw = hour % 12
        let humanHour = hourRaw == 0 ? 12 : hourRaw
        return "\(humanHour)"
    }

    var hourSuffix: String {
        guard hour % 6 == 0 else { return "" }
        return hour < 12 ? "AM" : "PM"
    }
}

extension CGPoint {
    init(_ size: CGSize) {
        self.init(x: size.width, y: size.height)
    }
}

struct Dial_Previews: PreviewProvider {
    static let scheme = ColorScheme.dark
    static var previews: some View {
        Group {
            VStack {
                Card {
                    Dial()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("backgroundCard"))
                    .preferredColorScheme(scheme)
                }
                .foregroundColor(Color("backgroundCard"))
                .padding()
            }

            Image("example")
                .resizable()
                .scaledToFit()
                .preferredColorScheme(scheme)
        }

    }
}
