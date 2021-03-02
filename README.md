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
