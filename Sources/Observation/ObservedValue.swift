import Chain

@propertyWrapper public struct Observed<T> {
    private var observedValue = ObservedValue<T>()
    
    public var didChangeHandler: Chain? {
        didSet {
            observedValue.didChangeHandler = didChangeHandler
        }
    }
    public var wrappedValue: T {
        didSet {
            observedValue.update(value: wrappedValue)
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

public class ObservedValue<T> {
    private(set) var value: T?
    
    public var didChangeHandler: Chain?
    
    public init(value: T? = nil) {
        self.value = value
    }
    
    public func update(value: T) {
        self.value = value
        
        _ = didChangeHandler?.run(name: "ObservedValue<\(T.self)>.didChangeHandler")
    }
}
