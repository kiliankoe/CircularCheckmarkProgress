import Foundation
import SwiftUI
import Combine

public struct CircularCheckmarkProgressViewStyle: ProgressViewStyle {
    public var strokeStyle = StrokeStyle(
        lineWidth: 10.0,
        lineCap: .round)
    public var showGuidingLine = true
    public var guidingLineWidth: CGFloat = 1.0
    public var showPercentage = true
    public var percentageFont = Font.system(.largeTitle, design: .monospaced).bold()
    public var finishedShape = CheckmarkShape()

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
                if configuration.fractionCompleted != 1.0 {
                    text(forPercentage: configuration.fractionCompleted ?? 0)
                        .font(percentageFont)
                }
            }
            if configuration.fractionCompleted == 1.0 {
                finishedShape
                    .stroke(style: strokeStyle)
            }
        }
    }
}

private class PreviewLoadingObject: ObservableObject {
    @Published var progress: Progress
    @Published var finished = false
    private var timer: AnyCancellable?

    init() {
        progress = Progress(totalUnitCount: 100)
    }

    func start() {
        timer = Timer.publish(every: 0.025, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.progress.completedUnitCount += 1
                if self.progress.isFinished {
                    self.timer = nil
                    self.finished = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.finished = false
                        self.progress.completedUnitCount = 0
                        self.start()
                    }
                }
            }
    }
}

private struct LoadingCheckmarkPreviewView: View {
    @ObservedObject var loading = PreviewLoadingObject()

    let pinkPurpleGradient = LinearGradient(gradient: Gradient(
                                                colors: [Color.pink, Color.purple]),
                                            startPoint: .top,
                                            endPoint: .bottom)

    var body: some View {
        ProgressView(loading.progress)
            .progressViewStyle(CircularCheckmarkProgressViewStyle())
//            .foregroundColor(.blue)
            .foreground(pinkPurpleGradient)
            .onAppear {
                loading.start()
            }
    }
}

struct LoadingCheckmark_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCheckmarkPreviewView()
            .frame(width: 200, height: 200)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
