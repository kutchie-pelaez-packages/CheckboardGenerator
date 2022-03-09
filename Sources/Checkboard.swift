import UIKit

public struct Checkboard: Hashable {
    public static let defaultWidth: Double = 8

    public init(
        size: CGSize,
        firstColor: UIColor = UIColor(light: 0xFFFFFF, dark: 0x606060),
        secondColor: UIColor = UIColor(light: 0xDADADA, dark: 0x383838),
        width: Double = Self.defaultWidth
    ) {
        self.size = size
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.width = width
    }

    public static var fullscreen: Checkboard {
        let screenSize = UIScreen.main.bounds.size
        let defaultWidth = Int(defaultWidth)

        var width = Int(screenSize.width).quotientAndRemainder(dividingBy: defaultWidth).quotient * defaultWidth
        if width < Int(screenSize.width) { width += defaultWidth }

        var height = Int(screenSize.height).quotientAndRemainder(dividingBy: defaultWidth).quotient * defaultWidth
        if height < Int(screenSize.height) { height += defaultWidth }

        return Checkboard(
            size: CGSize(
                width: width,
                height: height
            )
        )
    }

    let size: CGSize
    let firstColor: UIColor
    let secondColor: UIColor
    let width: Double

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(size.width)
        hasher.combine(size.height)
        hasher.combine(firstColor.hex)
        hasher.combine(secondColor.hex)
        hasher.combine(width)
    }
}
