import XCTest
@testable import MyLibrary


final class MyLibraryIntegrationTest: XCTestCase {
    func testIsWeatherApi() async throws {
        let weatherService = WeatherServiceImpl()
        do {
            let temperature = try await weatherService.getTemperature()
            XCTAssertNotNil(temperature)
            XCTAssert(type(of: temperature) == Int.self)
        } catch {
            print(error)
        }
    }
}
