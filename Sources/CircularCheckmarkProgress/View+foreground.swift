import SwiftUI

public extension View {
    func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        // The padding here is unfortunate, can this be fixed somehow?
        self.overlay(overlay.padding(-10))
            .mask(self)
    }
}
