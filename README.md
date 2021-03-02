# Observation

## What is this

This is a work in progress project to experiment with [Chain](https://github.com/0xLeif/Chain) and [E.num](https://github.com/0xLeif/E.num) in useful ways.

## Dependencies 

### [E.num](https://github.com/0xLeif/E.num)

#### [Variable](https://github.com/0xLeif/E.num/blob/main/Sources/E/Variable.swift)

```swift
public enum Variable: Hashable {
    case void
    case bool(Bool)
    case int(Int)
    case float(Float)
    case double(Double)
    case string(String)
    case set(Set<Variable>)
    case array([Variable])
    case dictionary([Variable: Variable])
}
```

#### [Function](https://github.com/0xLeif/E.num/blob/main/Sources/E/Function.swift)

```swift
public enum Function {
    case void(() -> ())
    case `in`((Variable) -> ())
    case out(() -> Variable)
    case `inout`((Variable) -> Variable)
}
```

### [Chain](https://github.com/0xLeif/Chain)


```swift
public indirect enum Chain {
    case end
    case complete(E.Function?)
    case link(E.Function, Chain)
    case background(E.Function, Chain)
    case multi([Chain])
}
```


***

## Example Code

```swift
let observedValue: ObservedValue<Int> = ObservedValue()

observedValue.didChangeHandler = .complete(
    .void {
        sleep(1)
        print("Done!")
        XCTAssertNotNil(observedValue.value)
    }
)

observedValue.update(value: 5)
observedValue.update(value: 15)
observedValue.update(value: 25)
```

### Property Wrapper

```swift
@Observed var index = 4

_index.didChangeHandler = .link(
    .void {
        viewModel.update(value: values[index])
    },
    .complete(
        .void {
            updateUI()
        }
    )
)

guard values.count < index && index >= 0 else {
    return
}

index += 1
```
