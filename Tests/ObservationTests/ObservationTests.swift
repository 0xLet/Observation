import XCTest
@testable import Observation

final class ObservationTests: XCTestCase {
    @Observed var ov = 4
    
    func testExample() {
        
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
        
        XCTAssertEqual(observedValue.value, 25)
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
}
