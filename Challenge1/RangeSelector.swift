//
//  RangeSelector.swift
//  Challenge1
//
//  Created by Quinn McHenry on 9/29/21.
//

import SwiftUI

struct RangeSelector: View {
    @Binding var length: Angle
    @Binding var rotation: Angle
    let width: CGFloat

    var body: some View {
        GeometryReader { proxy in
            RangeShape(length: length, width: width)
                .rotationEffect(rotation)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.rotation = CGPoint(x: proxy.size.width/2, y: proxy.size.height/2).angle(to: gesture.location)
                            print("x/y: \(gesture.translation) angle: \(self.rotation)")
                        }
//                            .onEnded { _ in
//                            }
                )

        }
    }
}

struct RangeShape: Shape {
    let length: Angle
    let width: CGFloat

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.midX, rect.midY)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        func point(at angle: Angle, length: CGFloat) -> CGPoint {
            let s = sin(angle.radians)
            let c = cos(angle.radians)
            return CGPoint(x: length * CGFloat(s) + center.x, y: length * CGFloat(c) + center.y)
        }
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: length, clockwise: false)
        path.addArc(center: point(at: Angle(degrees: 90) - length, length: radius - width/2), radius: width/2, startAngle: length, endAngle: length + Angle(degrees: 180), clockwise: false)
        path.addArc(center: center, radius: radius - width, startAngle: length, endAngle: .zero, clockwise: true)
        path.addArc(center: point(at: Angle(degrees: 90), length: radius - width/2), radius: width/2, startAngle: Angle(degrees: 180), endAngle: .zero, clockwise: false)
        return path
    }


}

struct RangeSelector_Previews: PreviewProvider {
    static var previews: some View {
        preview(degrees: 15)
        preview(degrees: 45)
        preview(degrees: 46)
        preview(degrees: 180)
        preview(degrees: 270)
        preview(degrees: 270, width: 10)
    }

    static func preview(degrees: Double, width: Double = 50) -> some View {
        RangeSelector(length: .constant(Angle(degrees: degrees)), rotation: .constant(Angle(degrees: 45)), width: width)
            .padding()
            .frame(width: 350, height: 350)
            .previewLayout(.sizeThatFits)
    }
}
