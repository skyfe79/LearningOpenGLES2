import XCTest
@testable import PaversFRP

final class UnitTests: XCTestCase {

  func testUnitEquality() {
    XCTAssertEqual(PaversFRP.Unit(), PaversFRP.Unit())
  }
}
