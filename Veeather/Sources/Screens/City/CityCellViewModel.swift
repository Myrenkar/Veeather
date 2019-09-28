import Foundation

protocol CityCellViewModelProtocol {
    var time: String { get }
    var temperature: String { get }

    func setImage(for: ImageView) 
}

final class CityCellViewModel: CityCellViewModelProtocol {
    private let forecast: Forecast
    private let iconProvider: IconProviding
    private let dateFormatterFactory = DateFormatterFactory()

    init(forecast: Forecast, iconProvider: IconProviding) {
        self.forecast = forecast
        self.iconProvider = iconProvider
    }

    var time: String {
        guard let date = dateFormatterFactory.apiDateFormatter.date(from: forecast.time) else { return "" }
        return dateFormatterFactory.weatherFormatter.string(from: date)
    }

    var temperature: String {
        return "Temperature: \(forecast.main.temp) °C"
    }

    private var iconID: String? {
        return forecast.weather.first?.icon
    }
    
    func setImage(for imageView: ImageView) {
        guard let iconID = iconID else { return }
        iconProvider.getIcon(id: iconID, scale: 2) { result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    imageView.originalImage = image
                }
            }
        }
    }
}
