import Alamofire
import Foundation

public protocol WeatherService {
    func getTemperature() async throws -> Int
}

class WeatherServiceImpl: WeatherService {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=imperial&appid=c0df1773d8d565eea93f6a97d8b93287"
    let mockUrl = "http://localhost:5000/data/2.5/weather"
    
    func getTemperature() async throws -> Int {
        var api_url = url
        let env = ProcessInfo.processInfo.environment["CI"]

        if (env != nil) {
            api_url = mockUrl
        }
        
        print(api_url)
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(api_url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
