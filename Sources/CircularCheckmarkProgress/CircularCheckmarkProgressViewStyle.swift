import Foundation
import SwiftUI

public struct CircularCheckmarkProgressViewStyle: ProgressViewStyle {
    public var strokeStyle = StrokeStyle(
        lineWidth: 10.0,
        lineCap: .round,
        lineJoin: .round
    )
    public var showGuidingLine = true
    public var guidingLineWidth: CGFloat = 1.0
    public var showPercentage = true
    public var percentageFont = Font.system(.largeTitle, design: .monospaced).bold()
    public var finishedShape = CheckmarkShape()
    public var finishedAnimation = Animation.spring(response: 0.55,
                                                    dampingFraction: 0.35)
                                            .speed(1.5)

    private static var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()

    private func text(forPercentage fraction: Double) -> Text {
        Text(
            Self.numberFormatter.string(from: NSNumber(value: fraction))!
        )
    }

    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if showGuidingLine {
                    Circle()
                        .stroke(lineWidth: guidingLineWidth)
            }
            Circle()
                .trim(from: 0, to: CGFloat(configuration.fractionCompleted ?? 0))
                .stroke(style: strokeStyle)
                .rotationEffect(.radians(.pi * 1.5), anchor: .center)
            if showPercentage {
                if !configuration.isFinished {
                    text(forPercentage: configuration.fractionCompleted ?? 0)
                        .font(percentageFont)
                }
            }

            finishedShape
                .stroke(style: strokeStyle)
                .scaleEffect(configuration.isFinished ? 1.0 : 0.0)
                .opacity(configuration.isFinished ? 1.0 : 0.0)
                .animation(finishedAnimation)
        }
    }
}

struct LoadingCheckmark_Previews: PreviewProvider {
    @ObservedObject static var loading = PreviewLoadingObject()

    static let pinkPurpleGradient = LinearGradient(gradient: Gradient(
                                                colors: [Color.pink, Color.purple]),
                                            startPoint: .top,
                                            endPoint: .bottom)

    static var previews: some View {
        HStack(spacing: 40) {
            ProgressView(loading.progress)
                .progressViewStyle(CircularCheckmarkProgressViewStyle(
                    showPercentage: false
                ))
                .foreground(pinkPurpleGradient)
                .frame(width: 200, height: 200)
            ProgressView(loading.progress)
                .progressViewStyle(CircularCheckmarkProgressViewStyle(
                    strokeStyle: StrokeStyle(lineWidth: 5.0),
                    finishedAnimation: .default
                ))
                .foregroundColor(loading.progress.isFinished ? .green : .blue)
                .frame(width: 200, height: 200)
        }
        .onAppear {
            loading.start()
        }
    }
}
