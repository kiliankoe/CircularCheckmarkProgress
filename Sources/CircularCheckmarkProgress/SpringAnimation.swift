import SwiftUI

struct SpringAnimation: ViewModifier {
    var configuration: ProgressViewStyleConfiguration

    func body(content: Content) -> some View {
        content
            .scaleEffect(configuration.isFinished ? 1.0 : 0.0)
            .opacity(configuration.isFinished ? 1.0 : 0.0)
            .animation(Animation.spring(response: 0.55, dampingFraction: 0.35).speed(1.5))
    }
}
