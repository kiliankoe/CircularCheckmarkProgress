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
    public var showPercentage = false
    public var percentageFont = Font.system(.largeTitle, design: .monospaced).bold()
    public var checkmarkAnimation: CheckmarkAnimationType = .trim

    public init(
        strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round),
        showGuidingLine: Bool = true,
        guidingLineWidth: CGFloat = 1.0,
        showPercentage: Bool = false,
        percentageFont: Font = Font.system(.largeTitle, design: .monospaced).bold(),
        checkmarkAnimation: CheckmarkAnimationType = .trim
    ) {
        self.strokeStyle = strokeStyle
        self.showGuidingLine = showGuidingLine
        self.guidingLineWidth = guidingLineWidth
        self.showPercentage = showPercentage
        self.percentageFont = percentageFont
        self.checkmarkAnimation = checkmarkAnimation
    }

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

            switch checkmarkAnimation {
            case .none:
                CheckmarkShape()
                    .stroke(style: strokeStyle)
                    .opacity(configuration.isFinished ? 1.0 : 0.0)
            case .trim:
                CheckmarkShape()
                    .trim(from: 0, to: configuration.isFinished ? 1.0: 0.0)
                    .stroke(style: strokeStyle)
                    .animation(Animation.easeInOut.speed(2.0))
                    .opacity(configuration.isFinished ? 1.0 : 0.0)
            case .spring:
                CheckmarkShape()
                    .stroke(style: strokeStyle)
                    .modifier(SpringAnimation(configuration: configuration))
                    .opacity(configuration.isFinished ? 1.0 : 0.0)
            }
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
                .progressViewStyle(CircularCheckmarkProgressViewStyle())
                .foreground(pinkPurpleGradient)
                .frame(width: 200, height: 200)
            ProgressView(loading.progress)
                .progressViewStyle(CircularCheckmarkProgressViewStyle(
                    strokeStyle: StrokeStyle(lineWidth: 5.0),
                    checkmarkAnimation: .spring
                ))
                .foregroundColor(.blue)
                .frame(width: 200, height: 200)
            ProgressView(loading.progress)
                .progressViewStyle(CircularCheckmarkProgressViewStyle(
                    strokeStyle: StrokeStyle(lineWidth: 2.0),
                    showGuidingLine: false,
                    showPercentage: true,
                    checkmarkAnimation: .none
                ))
                .frame(width: 200, height: 200)
        }
        .onAppear {
            loading.start()
        }
    }
}
