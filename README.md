# Observation


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
