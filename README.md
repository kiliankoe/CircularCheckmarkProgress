# CircularCheckmarkProgress

WWDC '20 introduced a new `ProgressView` view to SwiftUI which also has the option of styling it via `.progressViewStyle()` passing in a `ProgressViewStyle`. This package contains one such style, the `CircularCheckmarkProgressViewStyle`.

<img src="https://user-images.githubusercontent.com/2625584/86521713-ab60ce80-be54-11ea-9eed-045a343f0f72.gif" width="200px" alt="screen recording" />

```swift
ProgressView(/* ... */)
    .progressViewStyle(CircularCheckmarkProgressViewStyle())
    .foreground(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), 
                               startPoint: .top,
                               endPoint: .bottom))
```

## Configuration

On passing a `CircularCheckmarkProgressViewStyle` to the `.progressViewStyle()` modifier you have a few options to configure the style by optionally specifying the following arguments in its initializer. If not changed, they fall back to their listed default values.

```swift
var strokeStyle: StrokeStyle = StrokeStyle(lineWidth: 10.0, 
                                           lineCap: .round)
var showGuidingLine = true
var guidingLineWidth: CGFloat = 1.0
var showPercentage = true
var percentageFont = Font.system(.largeTitle, design: .monospaced).bold()
var finishedShape = CheckmarkShape()
```

This package also exposes a view modifier called `.foreground()` which you can use to overlay a `ProgressView` (or others) entirely with a gradient of your choice (see example above). Otherwise feel free to use `foregroundColor()` to tint to your liking. 

## Installation

CircularCheckmarkProgress is available via Swift Package Manager. Just add this project's clone URL to your Xcode project.
