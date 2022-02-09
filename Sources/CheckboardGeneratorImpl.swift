import Core
import CoreUI
import UIKit

private let filterName = "CICheckerboardGenerator"
private let context = CIContext()

struct CheckboardGeneratorImpl: CheckboardGenerator {
    private func generate(
        _ checkboard: Checkboard,
        for userInterfaceStyle: UIUserInterfaceStyle
    ) -> UIImage {
        guard let filter = CIFilter(name: filterName) else {
            safeCrash()
            return UIImage()
        }

        let center = CIVector(x: 0, y: 0)
        let color0 = CIColor(color: checkboard.firstColor.forUserInterfaceStyle(userInterfaceStyle))
        let color1 = CIColor(color: checkboard.secondColor.forUserInterfaceStyle(userInterfaceStyle))
        let sharpness = NSNumber(integerLiteral: 1)
        let width = checkboard.width as NSNumber

        filter.setValue(center, forKey: "inputCenter")
        filter.setValue(color0, forKey: "inputColor0")
        filter.setValue(color1, forKey: "inputColor1")
        filter.setValue(sharpness, forKey: "inputSharpness")
        filter.setValue(width, forKey: "inputWidth")

        guard let output = filter.outputImage else {
            safeCrash()
            return UIImage()
        }

        guard let cgImage = context.createCGImage(
            output,
            from: CGRect(
                origin: .zero,
                size: checkboard.size
            )
        ) else {
            safeCrash()
            return UIImage()
        }

        return UIImage(cgImage: cgImage)
    }


    // MARK: - CheckboardGenerator

    func generate(_ checkboard: Checkboard) -> UIImage {
        let lightImage = generate(
            checkboard,
            for: .light
        )
        let darkImage = generate(
            checkboard,
            for: .dark
        )

        let result = UIImage()
        result.imageAsset!.register(lightImage, with: .light)
        result.imageAsset!.register(darkImage, with: .dark)

        return lightImage
    }
}
