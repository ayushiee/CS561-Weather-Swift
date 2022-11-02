import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
    // Test to check if API response JSON is of Weather type
    func testIsResponseJSONDecodable() throws {
        // static actual JSON Response
        let mockResponse = """
        {
            "coord": {
              "lon": -123.262,
              "lat": 44.5646
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "base": "stations",
            "main": {
              "temp": 289.96,
              "feels_like": 289.79,
              "temp_min": 288.55,
              "temp_max": 291.96,
              "pressure": 1016,
              "humidity": 80
            },
            "visibility": 10000,
            "wind": {
              "speed": 1.54,
              "deg": 230
            },
            "clouds": {
              "all": 100
            },
            "dt": 1664418453,
            "sys": {
              "type": 2,
              "id": 2040223,
              "country": "US",
              "sunrise": 1664374040,
              "sunset": 1664416792
            },
            "timezone": -25200,
            "id": 5720727,
            "name": "Corvallis",
            "cod": 200
          }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(Weather.self, from: mockResponse)
            XCTAssert(type(of: data) == Weather.self)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    // Test to check of failure when JSON is not of Weather type
    func testIsResponseNotJSONDecodable() throws {
        let mockResponse = """
        {
            "coord": {
              "lon": -123.262,
              "lat": 44.5646
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "base": "stations",
            "maine": {
              "temp": 289.96,
              "feels_like": 289.79,
              "temp_min": 288.55,
              "temp_max": 291.96,
              "pressure": 1016,
              "humidity": 80
            },
            "visibility": 10000,
            "wind": {
              "speed": 1.54,
              "deg": 230
            },
            "clouds": {
              "all": 100
            },
            "dt": 1664418453,
            "sys": {
              "type": 2,
              "id": 2040223,
              "country": "US",
              "sunrise": 1664374040,
              "sunset": 1664416792
            },
            "timezone": -25200,
            "id": 5720727,
            "name": "Corvallis",
            "cod": 200
          }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(Weather.self, from: mockResponse)
            XCTAssertFalse(type(of: data) == Weather.self)
        } catch {
            XCTAssertNotNil(error)
        }
    }

}
