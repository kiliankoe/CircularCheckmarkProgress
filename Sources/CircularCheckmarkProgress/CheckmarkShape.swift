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

struct CheckmarkShape_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkShape()
            .stroke(lineWidth: 10)
            .frame(width: 200, height: 200)
            .previewLayout(.sizeThatFits)
    }
}
