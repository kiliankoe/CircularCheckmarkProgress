import SwiftUI

// see https://stackoverflow.com/a/59858089/1843020

public extension View {
    func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        // The padding here is unfortunate, can this be fixed somehow?
        self.overlay(overlay.padding(-10))
            .mask(self)
    }
}
