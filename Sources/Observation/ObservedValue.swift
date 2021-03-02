import E
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
            _ = observedValue.update(value: wrappedValue)
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

public class ObservedValue<T> {
    private(set) var value: T?
    
    public var callChain: Chain = .end
    public var didChangeHandler: Chain?
    
    public init(value: T? = nil) {
        self.value = value
        self.callChain = .complete(
            .out { [weak self] in
                self?.didChangeHandler?.run(name: "ObservedValue<\(T.self)>.didChangeHandler") ?? .void
            }
        )
    }
    
    @discardableResult
    public func update(value: T) -> Variable {
        self.value = value
        
        return callChain.run(name: "ObservedValue<\(T.self)>.callChain")
    }
}
