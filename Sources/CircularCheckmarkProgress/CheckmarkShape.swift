import SwiftUI

public struct CheckmarkShape: Shape {
    private var trim: CGFloat = 0.0

    public func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.width * 0.3, y: rect.height * 0.53))
            p.addLine(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.68))
            p.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35))
        }
    }
}
