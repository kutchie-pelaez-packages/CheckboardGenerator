public struct CheckboardGeneratorFactory {
    public init() { }

    public func produce() -> CheckboardGenerator {
        CheckboardGeneratorImpl()
    }
}
