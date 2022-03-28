import Core
import CoreUI
import UIKit

private let filterName = "CICheckerboardGenerator"
private let context = CIContext()
private var cache = [Int: UIImage]()

public struct CheckboardGenerator {
    private static func generate(_ checkboard: Checkboard, for userInterfaceStyle: UIUserInterfaceStyle) -> UIImage {
        guard let filter = CIFilter(name: filterName) else {
            safeCrash()
            return UIImage()
        }

        let scale = UIScreen.main.scale
        let center = CIVector(x: 0, y: 0)
        let color0 = CIColor(color: checkboard.firstColor.forUserInterfaceStyle(userInterfaceStyle))
        let color1 = CIColor(color: checkboard.secondColor.forUserInterfaceStyle(userInterfaceStyle))
        let sharpness = NSNumber(integerLiteral: 1)
        let width = checkboard.width * scale as NSNumber

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
                size: CGSize(
                    width: checkboard.size.width * scale,
                    height: checkboard.size.height * scale
                )
            )
        ) else {
            safeCrash()
            return UIImage()
        }

        return UIImage(cgImage: cgImage)
            .scaledPreservingAspectRatio(targetSize: checkboard.size)
    }

    // MARK: - CheckboardGenerator

    public static func generate(_ checkboard: Checkboard) -> UIImage {
        if let cachedImage = cache[checkboard.hashValue] {
            return cachedImage
        }

        let lightImage = generate(checkboard, for: .light)
        let darkImage = generate(checkboard, for: .dark)

        let traitsResolver: (UIUserInterfaceStyle) -> UITraitCollection = { userInterfaceStyle in
            UITraitCollection(
                traitsFrom: [
                    UITraitCollection(userInterfaceStyle: userInterfaceStyle),
                    UITraitCollection(displayScale: UIScreen.main.scale)
                ]
            )
        }

        let result = UIImage()
        result.imageAsset!.register(lightImage, with: traitsResolver(.light))
        result.imageAsset!.register(darkImage, with: traitsResolver(.dark))

        let preparedImage = result.preparingForDisplay() ?? result
        cache[checkboard.hashValue] = preparedImage

        return preparedImage
    }
}
