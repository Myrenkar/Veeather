import Foundation

protocol DateFormatterFactoryProtocol {
    var apiDateFormatter: DateFormatter { get }
    var weatherFormatter: DateFormatter { get }
}

final class DateFormatterFactory: DateFormatterFactoryProtocol {
    lazy var apiDateFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_US_POSIX")
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formater.timeZone = TimeZone(secondsFromGMT: 0)
        return formater
    }()

    lazy var weatherFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.locale = Locale.current
        formater.dateFormat = "EEE, MMM d"
        return formater
    }()

}
