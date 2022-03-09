import UIKit

public struct Checkboard: Hashable {
    public init(
        size: CGSize,
        firstColor: UIColor = UIColor(light: 0xFFFFFF, dark: 0x606060),
        secondColor: UIColor = UIColor(light: 0xDADADA, dark: 0x383838),
        width: Double = 8
    ) {
        self.size = size
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.width = width
    }

    public static var fullscreen: Checkboard {
        Checkboard(
            size: UIScreen.main.bounds.size
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
