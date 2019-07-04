//
//  WYWeatherController.swift
//  WYWeather
//
//  Created by study on 2019/6/26.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit
import IHProgressHUD

class WYWeatherController: UIViewController {
    /// 背景图片
    private let bgImageView = UIImageView()
    /// 天气度数
    private let degreesLabel = UILabel()
    /// 状况： 多云
    private let statusLabel = UILabel()
    /// 最低温度
    private let lessTemp = WYViewStayValue2()
    /// 最高温度
    private let highTemp = WYViewStayValue2()
    /// 搜索框
    private let barView = UISearchBar()
    // 我的城市
    private let cityLabel = UILabel()
    /// 搜索城市名称： 默认北京
    private var cityString = "1"
    private let visibView = WYViewStayleValue1()
    private let windView = WYViewStayleValue1()
    private let humiditeView = WYViewStayleValue1()
    private let pressureView = WYViewStayleValue1()


    
    // 通过城市名称或城市ID查询天气预报情况
    private var weatherModel: WYDetailModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // setBGPNGView()
        
        // 198, 226 ,255
        self.view.backgroundColor = UIColor(red: 198/255.0, green: 226/255.0, blue: 255/255.0, alpha: 1)
        
        if cityString == "0" {
            setupNetwork(city: "1")
        } else {
            setupNetwork(city: cityString)
        }
        
        
        /// 搜索框
        setupView()
    
        /// 天气度数
        setupDegreesView()
        /// 状况： 多云
        setupStatusView()
        /// 最高温度，最低温度
        setHighAndLessTempView()
        /// 其他内容
        setOtherView()
        
    }
}

// MARK:- 网络请求
extension WYWeatherController {
    // 通过城市名称或城市ID查询天气预报情况
    private  func setupNetwork(city: String) {
        let parameters: Dictionary = ["key": "f172dc7b7ce6344f78368323541a8051",
                                      "city": city
        ]
        let aURL = "http://apis.juhe.cn/simpleWeather/query"
        
        
        WYAlamofire.api(url: aURL, parameters: parameters, success: { (json) in
            let json2 = JSON(json)
            let detailModel = WYDetailModel.init(json: json2)
            
            if detailModel.code != 0 {
                print("网络错误")
                let aCode = detailModel.code
                let aMsg = detailModel.reason
                let aError = "\(aCode!) - \(aMsg!)"
                IHProgressHUD.showInfowithStatus("\(aError)")
                return
            }
            self.weatherModel = detailModel
            self.setupOne()
            self.setupTwo()
            self.view.setNeedsDisplay()
            
        }) { (error) in
            print("返回的错误")
            IHProgressHUD.showInfowithStatus("网络异常，请稍后重试")

        }
    }
    
    private func setupOne() {
        
        let aWeatherModel = self.weatherModel?.result
        self.degreesLabel.text = aWeatherModel?.realtime.temperature
        self.statusLabel.text = aWeatherModel?.realtime.info //"多云"
        
        let temp = aWeatherModel?.future[0].temperature
        
        // 字符串切割 "2/44°"
        let arraySubstrings: [Substring] = temp!.split(separator: "/")
        let arrayStrings: [String] = arraySubstrings.compactMap { "\($0)" }
        
        let lesTStr = "\(arrayStrings[0])°C"
        self.lessTemp.setTemp(text: lesTStr)
        self.highTemp.setTemp(text: arrayStrings[1])
        
        let cityText =  aWeatherModel?.city ?? ""
        self.cityLabel.text = "我的城市 - \(cityText)"
    }
    
    private func setupTwo() {
        
        let aWeatherModel = self.weatherModel?.result?.realtime
        
        /// 湿度
        visibView.setSubTitle(title: (aWeatherModel?.humidity)!)
        /// 风向
        windView.setSubTitle(title: (aWeatherModel?.direct)!)
        /// 风力
        humiditeView.setSubTitle(title: (aWeatherModel?.power)!)
        /// 空气质量
        pressureView.setSubTitle(title: (aWeatherModel?.aqi)!)
    }
}


extension WYWeatherController {
    /// 天气度数
    private func setupDegreesView() {
        degreesLabel.frame = CGRect(x: spaceX, y: 300, width: 158, height: 86)
        degreesLabel.text = "34°"
        degreesLabel.textColor = aTextColor
        degreesLabel.font = UIFont.systemFont(ofSize: 86)
//        self.bgImageView.addSubview(degreesLabel)
        self.view.addSubview(degreesLabel)
    }
    
    /// 状况： 多云
    private func setupStatusView() {
        let aSLY: CGFloat = degreesLabel.frame.maxY + 31
        let aSLW: CGFloat = 135
        statusLabel.frame = CGRect(x: spaceX, y: aSLY, width: aSLW, height: labelH)
        statusLabel.text = "多云"
        statusLabel.textColor = aTextColor
        statusLabel.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(statusLabel)
    }
    
    /// 最高温度，最低温度
    private func setHighAndLessTempView() {
        // 最低温度
        let aLFY: CGFloat = statusLabel.frame.maxY + spaceY
        let aLFW: CGFloat = 60
        let aLFH: CGFloat = 16
       let lessFrame = CGRect(x: spaceX, y: aLFY, width: aLFW, height: aLFH)
       
        lessTemp.frame = lessFrame
        lessTemp.setImage(image: "lessTemp")
        lessTemp.setTemp(text: "13°")
        // setTempView(frame: lessFrame, imageString: "lessTemp", textString: "23°")
        self.view.addSubview(lessTemp)
        
        // 最高温度
        let aHFX: CGFloat = lessTemp.frame.maxX + 20
        let highFrame = CGRect(x: aHFX, y: aLFY, width: aLFW, height: aLFH)
        highTemp.frame = highFrame
        highTemp.setImage(image: "highTemp")
        highTemp.setTemp(text: "14°")
        self.view.addSubview(highTemp)
    }
}

// MARK:- 能见度、东、湿度
extension WYWeatherController {
    /// 其他内容
    private func setOtherView() {
        /// 能见度
        let aVY: CGFloat = lessTemp.frame.maxY + 30
        let aVW: CGFloat = (kScreenWeight - 18 * 2 - 10) / 2
        let aVH: CGFloat = 30
        let visibrame = CGRect(x: spaceX, y: aVY, width: aVW, height: aVH)
//        visibView.setImage(image: "highTemp")
        visibView.frame = visibrame
        visibView.setMainTitle(title: "湿度")
        visibView.setSubTitle(title: "54")
        self.view.addSubview(visibView)
        
        /// 风向：东
        let aWX: CGFloat = visibView.frame.maxX + 5
        let windFrame = CGRect(x: aWX, y: aVY, width: aVW, height: aVH)
//        let windView = WYViewStayleValue1(frame: windFrame)
//        windView.setImage(image: "highTemp")
        windView.frame = windFrame
        windView.setMainTitle(title: "风向")
        windView.setSubTitle(title: "2级")
        self.view.addSubview(windView)
        
        
        
        /// 湿度
        let aHY: CGFloat = visibView.frame.maxY + 30
//        let aHX: CGFloat = windView.frame.maxX + 5
        let humFrame = CGRect(x: spaceX, y: aHY, width: aVW, height: aVH)
//        let humiditeView = WYViewStayleValue1(frame: humFrame)
//        humiditeView.setImage(image: "highTemp")
        humiditeView.frame = humFrame
        humiditeView.setMainTitle(title: "风力")
        humiditeView.setSubTitle(title: "43%")
        self.view.addSubview(humiditeView)
        
        /// 气压
        let aPX: CGFloat = humiditeView.frame.maxX + 5
        let pressureFrame = CGRect(x: aPX, y: aHY, width: aVW, height: aVH)
//        let pressureView = WYViewStayleValue1(frame: pressureFrame)
//        pressureView.setImage(image: "highTemp")
        pressureView.frame = pressureFrame
        pressureView.setMainTitle(title: "空气质量")
        pressureView.setSubTitle(title: "111.1hPa")
        self.view.addSubview(pressureView)
    }
}


extension WYWeatherController {
    private func setupView() {
        // 我的城市
        cityLabel.frame = CGRect(x: spaceX, y: 64, width: kScreenWeight - spaceX*2, height: 86)
        cityLabel.text = "我的城市"
        cityLabel.textColor = aTextColor
        cityLabel.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(cityLabel)
        
        // 搜索框
        barView.frame = CGRect(x: spaceX, y: cityLabel.frame.maxY + 10, width: kScreenWeight - spaceX*2, height: 86)
        barView.placeholder = "搜索城市/风景区"
        // 设置搜索框整体的风格 不显示背景
        barView.searchBarStyle = UISearchBar.Style.minimal
        barView.delegate = self
        // 设置 取消文字
        barView.showsCancelButton = true
        // 拿到取消按钮
        let cancleBtn: UIButton = barView.value(forKey: "cancelButton") as! UIButton
        cancleBtn.setTitle("取消", for: .normal)
        
        
        self.view.addSubview(barView)
    }
}

extension WYWeatherController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        barView.showsCancelButton = true
    }
    
    // 点击 searchBtn 后，在 搜索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchButton")
        self.barView.resignFirstResponder()
        cityString = barView.text ?? "0"
        
        print("cityString = \(cityString)")
        
        if cityString == "0" {
            setupNetwork(city: "1")
        } else {
            setupNetwork(city: cityString)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.barView.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        barView.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let inputStr = searchText
        
        print("inputStr = \(inputStr)")
    }
}
