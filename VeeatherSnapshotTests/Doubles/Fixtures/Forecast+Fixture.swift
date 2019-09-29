@testable import Veeather

extension Forecast {
    static func fixture() -> [Forecast] {
        return [
            Forecast(temparature: Temperature(temp: -1),
                     weather: [Weather(information: "Hello", icon: nil)],
                     time: "2017-01-30 18:00:00"
            ),
            Forecast(temparature: Temperature(temp: 100),
                     weather: [Weather(information: "From", icon: nil)],
                     time: "2018-01-30 18:00:00"
            ),
            Forecast(temparature: Temperature(temp: 101),
                     weather: [Weather(information: "the other", icon: nil)],
                     time: "2019-01-30 18:00:00"
            ),
            Forecast(temparature: Temperature(temp: 201),
                     weather: [Weather(information: "side", icon: nil)],
                     time: "2020-01-30 18:00:00"
            )
        ]
    }

}
