import UIKit

public struct Checkboard {
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

    let size: CGSize
    let firstColor: UIColor
    let secondColor: UIColor
    let width: Double
}
