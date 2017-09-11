import Foundation
import XCTest
import PaversFRP

final class AnyErrorTests: XCTestCase {
	static var allTests: [(String, (AnyErrorTests) -> () throws -> Void)] {
		return [ ("testAnyError", testAnyError) ]
	}

	func testAnyError() {
		let error = Error.a
		let anyErrorFromError = AnyError(error)
		let anyErrorFromAnyError = AnyError(anyErrorFromError)
		XCTAssertTrue(anyErrorFromError == anyErrorFromAnyError)
	}
}
