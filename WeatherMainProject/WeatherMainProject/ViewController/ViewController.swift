//
//  ViewController.swift
//  WeatherMainProject
//
//  Created by Алексей on 22.07.21.
//

import UIKit

    struct OtherDayModel {
        let date: String
        let minTemp: Int
        let maxtemp: Int
        let icon: String
    }

    struct OtherInfoModel {
        let title: String
        let data: String
    }

    struct CurrentDayModel {
        let city: String
        let minTemp: Int
        let maxtemp: Int
        let currentTemp: Int
        let description: String
        let timeZone: TimeZone
    }


    enum CellDataType {
    //    case currentDay(currentDay: CurrentDayModel)
        case otherDays(days: OtherDayModel)
        case otherInfo(info: [OtherInfoModel])

    }

    struct CityWeather {
        let mainInfo: CurrentDayModel
        let cityData: [CellDataType]
    }

    enum ScrollDirection {
        case vertical
        case horizontal
    }
        
    final class ViewController: UIViewController  {
        
        @IBOutlet private weak var weatherCollectionView: UICollectionView!
        
        @IBOutlet private weak var weatherPageControl: UIPageControl!
        
        private var dataSourceAllCities: [CityWeather] = []
        
        private var attrOneCity: Bool = false
        private var oneCityData: CityWeather?
        
        private var dataMainInfo: CurrentDayModel!
        private var dataSource: [CellDataType] = []
        
        private let dataFetcher = DataFetcherService()
        private let dataFetcherCurrentDay = DataFetcherService()
        
        private var arrayCities: [String] = ["Minsk"] // подтянуть из user defaults
        private var currentScrollDirection = ScrollDirection.horizontal
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            weatherCollectionView.dataSource = self
            weatherCollectionView.delegate = self
            
            setPresentationStyleCV(collectionView: weatherCollectionView, scrollDirection: currentScrollDirection)
            setPageControl()
            
            weatherCollectionView.register(UINib(nibName: CityCollectionViewCell.description(), bundle: nil), forCellWithReuseIdentifier: CityCollectionViewCell.description())
            weatherCollectionView.register(UINib(nibName: CityVerticalCollectionViewCell.description(), bundle: nil), forCellWithReuseIdentifier: CityVerticalCollectionViewCell.description())
            weatherCollectionView.register(UINib(nibName: LastVerticalCVCell.description(), bundle: nil), forCellWithReuseIdentifier: LastVerticalCVCell.description())
            
            for city in arrayCities {
                addWeatherForCity(city: city, oneCity: false)
            }
                 
        }
        
        @objc private func pageControlDidChanged(_ sender: UIPageControl) {
        
            let current = sender.currentPage
            weatherCollectionView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: true)
        }
        
        private func setPresentationStyleCV(collectionView: UICollectionView, scrollDirection: ScrollDirection) {
            currentScrollDirection = scrollDirection
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                switch scrollDirection {
                case .vertical:
                    layout.scrollDirection = UICollectionView.ScrollDirection.vertical
                default:
                    layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
               }
               
            }
            
        }
        
        private func setPageControl() {
            switch currentScrollDirection {
            case .vertical:
                weatherPageControl.isHidden = true
            case .horizontal:
             //   weatherPageControl.isHidden = false
                weatherPageControl.setIndicatorImage(UIImage.init(systemName: "location.fill"), forPage: 0)
                weatherPageControl.hidesForSinglePage = true
                weatherPageControl.addTarget(self, action: #selector(pageControlDidChanged(_:)), for: .valueChanged)
                
            }
        }
        
        
        private func addWeatherForCity(city: String, oneCity: Bool) {
            
            attrOneCity = oneCity
            dataFetcher.getWeatherDays(cnt: "10", cityName: city) { [weak self] response in
                guard let self = self, let response = response else {return}
                self.fillDataSource(response: response)
                
                self.dataFetcherCurrentDay.getWeather(cityName: city) { [weak self] response in
                    guard let self = self, let responseCurrentday = response else {return}
                    self.addDataSource(response: responseCurrentday)
                    
                }
            }
        }
        
        
        private func addDataSource(response: WeatherResponse) {
            
            var dataOtherInfo: [OtherInfoModel] = []
            var currentTimeZone: TimeZone = .current
            // main info
            guard let city = response.name else {return}
            
            
            if let timeZone = response.timezone {
                currentTimeZone = TimeZone(secondsFromGMT: timeZone) ?? .current
            }
            
            dataMainInfo = CurrentDayModel(city: city, minTemp: Int(round(response.main?.temp_min ?? 0)), maxtemp: Int(round(response.main?.temp_max ?? 0)), currentTemp: Int(round(response.main?.temp ?? 0)), description: response.weather?.first?.description ?? "", timeZone: currentTimeZone)
            
       
            // other info
            if let sys = response.sys {
                
                var dayTitleString = ""
                
                if let epochInt = sys.sunrise {
                    dayTitleString = DateFormatter.configureDataStringFrom(epoch: epochInt, dateFormat: .timeFull)
                    dataOtherInfo.append(OtherInfoModel(title: "ВОСХОД СОЛНЦА", data: dayTitleString))
                }
                   
                if let epochInt = sys.sunset {
                    dayTitleString = DateFormatter.configureDataStringFrom(epoch: epochInt, dateFormat: .timeFull)
                    dataOtherInfo.append(OtherInfoModel(title: "ЗАХОД СОЛНЦА", data: dayTitleString))
                }
              
            }

    //      -  "ВЕРОЯТНОСТЬ ДОЖДЯ"

            if let main = response.main {
                if let humidity = main.humidity {
                    dataOtherInfo.append(OtherInfoModel(title: "ВЛАЖНОСТЬ", data: "\(humidity)%"))
                }

                //      +-  "ВЕТЕР"
                
                if let feels_like = main.feels_like {
                    dataOtherInfo.append(OtherInfoModel(title: "ОЩУЩАЕТСЯ КАК", data: "\(Int(round(feels_like)))°"))
                }

                if let pressure = main.pressure {
                    dataOtherInfo.append(OtherInfoModel(title: "ДАВЛЕНИЕ", data: "\(Double(pressure)*0.75) мм рт.ст."))
                }
            }

            if let wind = response.wind {
                guard let speed = wind.speed, let deg = wind.deg  else {return}
                dataOtherInfo.append(OtherInfoModel(title: "ВЕТЕР", data: "\(speed) м/с"))
            }

    //   -    "ОСАДКИ"

    //   +    "ДАВЛЕНИЕ"

            if let visibility = response.visibility {
                dataOtherInfo.append(OtherInfoModel(title: "ВИДИМОСТЬ", data: "\(Double(visibility/100)/10) км"))
            }
    //    -    "УФ-ИНДЕКС"

            self.dataSource.append(.otherInfo(info: dataOtherInfo))
          
            if self.attrOneCity {
                self.oneCityData = CityWeather(mainInfo: dataMainInfo, cityData: dataSource)
            } else {
                self.dataSourceAllCities.append(CityWeather(mainInfo: dataMainInfo, cityData: dataSource))
                self.weatherCollectionView.reloadData()
            }
            self.dataSource.removeAll()
          
        }
        
        func fillDataSource(response: WeatherDaysResponse) {
           
            // other days
            guard let days = response.list else {return}
            for day in days {
                
                var dayTitleString = ""
                
                if let epochInt = day.dt {
                    
                    dayTitleString = DateFormatter.configureDataStringFrom(epoch: epochInt, dateFormat: .dayTitle)
                    
                    guard let minTemp = day.temp?.min, let maxTemp = day.temp?.max, let icon = day.weather?.first?.icon else {return}
                
                    let minTempInt = Int(round(minTemp))
                    let maxTempInt = Int(round(maxTemp))
                    
                    dataSource.append(.otherDays(days: OtherDayModel(date: dayTitleString, minTemp: minTempInt, maxtemp: maxTempInt, icon: "http://openweathermap.org/img/wn/\(icon)@2x.png")))
                }
            }
        }
        
        @IBAction private func addCityBtn(_ sender: UIButton) {
       
            setPresentationStyleCV(collectionView: weatherCollectionView, scrollDirection: .vertical)
            setPageControl()
            weatherCollectionView.reloadData()
            
        }
      
        
    }

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate
    extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let count = dataSourceAllCities.count
            switch currentScrollDirection {
            case .vertical:
                weatherPageControl.numberOfPages = 1
                return (count+1)
            default:
                weatherPageControl.numberOfPages = count
                return count
            }
       //     weatherPageControl.numberOfPages = count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            switch currentScrollDirection {
            case .vertical:
                if indexPath.row == dataSourceAllCities.count {
                    let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: LastVerticalCVCell.description(), for: indexPath) as! LastVerticalCVCell
                    cell.delegate = self
                    return cell
                } else {
                    
                    let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: CityVerticalCollectionViewCell.description(), for: indexPath) as! CityVerticalCollectionViewCell
                    if indexPath.row == 0 {
                        cell.setupCityVerticalCell(cityTime: dataSourceAllCities[indexPath.item].mainInfo.city, place: "Моя геопозиция", temperature: dataSourceAllCities[indexPath.item].mainInfo.currentTemp, timeZone: dataSourceAllCities[indexPath.item].mainInfo.timeZone)
                    } else {
                        cell.setupCityVerticalCell(cityTime: "", place: dataSourceAllCities[indexPath.item].mainInfo.city, temperature: dataSourceAllCities[indexPath.item].mainInfo.currentTemp, timeZone: dataSourceAllCities[indexPath.item].mainInfo.timeZone)
                    }
                    return cell
                }
            case .horizontal:
                let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.description(), for: indexPath) as! CityCollectionViewCell
                cell.setupCityCVCell(model: dataSourceAllCities[indexPath.item])
                return cell
                
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch currentScrollDirection {
            case .vertical:
                if indexPath.row == dataSourceAllCities.count {
                    return CGSize(width: collectionView.bounds.width, height: 50)
                } else {
                    return CGSize(width: collectionView.bounds.width, height: 80)
                }
            case .horizontal:
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
                
            }
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            switch currentScrollDirection {
            case .vertical:
                return
            case .horizontal:
                let width = scrollView.frame.width - (scrollView.contentInset.left*2)
                let index = scrollView.contentOffset.x/width
                let roundedIndex = round(index)
                weatherPageControl.currentPage = Int(roundedIndex)
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch currentScrollDirection {
            case .vertical:
                if indexPath.row != dataSourceAllCities.count {
                    
                    setPresentationStyleCV(collectionView: weatherCollectionView, scrollDirection: .horizontal)
                    weatherCollectionView.reloadData()
                    
                    let current = indexPath.row
                    weatherCollectionView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: true)
                    setPageControl()
                }
            default:
                return
            }
        }
        
    }

    extension ViewController: LastVerticalCVCellDelegate {
        func addCity(city: String) {
            
            present(SearchPlaceViewController(), animated: true, completion: nil)
            
    //        addWeatherForCity(city: city, oneCity: true)
    //        if let oneCityData = oneCityData {
    //            let oneCityController = OneCityTVController(model: oneCityData)
    //            oneCityController.delegate = self
    //        //    navigationController?.pushViewController(oneCityController, animated: true)
    //            present(oneCityController, animated: true, completion: nil)
    //        }
    //
        }
        
    }

    // MARK: - OneCityTVControllerDelegate
    extension ViewController: OneCityTVControllerDelegate {
        func addCity(cityData: CityWeather) {
            self.dataSourceAllCities.append(cityData)
            self.weatherCollectionView.reloadData()
        }
        
    }

