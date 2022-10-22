import XCTest
@testable import MyLibrary


final class MyLibraryIntegrationTest: XCTestCase {
    // Integration test to check if API responds
    func testIsWeatherApiResponse() async throws {
        let weatherService = WeatherServiceImpl()
        do {
            let temperature = try await weatherService.getTemperature()
            XCTAssertNotNil(temperature)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    // Checks if captured weather temperature is lucky
    func testIsWeatherLucky() async throws {
        let myLibrary = MyLibrary()
        do {
            // Check successful api request and getTemperature() execution to return Int
            let temperature = try await myLibrary.weatherService.getTemperature()
            XCTAssert(type(of: temperature) == Int.self)
            
            // Check if response temp is lucky
            let isLucky = await myLibrary.isLucky(temperature)
            XCTAssertNotNil(isLucky)
        } catch {
            XCTAssertNil(error)
        }
    }
}
