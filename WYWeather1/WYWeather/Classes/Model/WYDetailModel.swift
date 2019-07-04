//
//  WYDetailModel.swift
//  WYWeather
//
//  Created by study on 2019/7/3.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit

class WYDetailModel: NSObject {
    /// 返回码，0为查询成功
    var code: Int?
    /// reason: 返回说明
    var reason: String?
    /// 返回结果集
    var result: detailReasonModel?

    init(json: JSON) {
        self.code = json["error_code"].int ?? 0
        self.reason = json["reason"].string ?? ""
        
        if json["result"].count != 0 {
            self.result = detailReasonModel(jsonData: json["result"])
        }
    }
}

struct detailReasonModel {
    
    /// 城市
    var city: String?
    /// 今天天气情况
    var realtime: detailsRealtimeModel
    /// 未来5天天气情况
    var future: [detailsFutureModel]
    
    
    init(jsonData: JSON) {
        city = jsonData["city"].string
        realtime = detailsRealtimeModel(jsonData: jsonData["realtime"])
        future = jsonData["future"].array!.compactMap({ (JSON) -> detailsFutureModel? in
//            print("JSON = \(JSON)")
            let ide = detailsFutureModel(jsonData: JSON)
//            print("ide = \(ide)")
            return ide
        })
            //detailsFutureModel(jsonData: jsonData["future"].arrayObject)
        //[detailsFutureModel(jsonData: jsonData["future"])]
    }
}

struct detailsRealtimeModel {
    
    /// 当前摄氏度
    var temperature:String?
    /// 湿度
    var humidity:String?
    /// 天气：晴
    var info:String?
    /// 风的大小
    var wid:String?
    ///  风向 "南风转西南风"
    var direct:String?
    ///  风力："3级",
    var power:String?
    /// 空气质量指数:"44" 空气质量指数，可能为空
    var aqi:String?
    
    
    init(jsonData: JSON) {
        temperature = jsonData["temperature"].string
        humidity = jsonData["humidity"].string
        info = jsonData["info"].string
        wid = jsonData["wid"].string
        direct = jsonData["direct"].string
        power = jsonData["power"].string
        aqi = jsonData["aqi"].string
    }
}

struct detailsFutureModel {

    /// 日期
    var date: String?
    /// 摄氏度
    var temperature: String?
    /// 风 的大小
    var wid: detailsFutureWidModel
    /// 天气：晴
    var weather: String?
    /// "南风转西南风"
    var direct: String?
    
    init(jsonData: JSON) {
        date = jsonData["date"].string
        temperature = jsonData["temperature"].string
        wid = detailsFutureWidModel(jsonData: jsonData["wid"])
        weather = jsonData["weather"].string
        direct = jsonData["direct"].string
    }
}

struct detailsFutureWidModel {
    
    ///  白天风力
    var day: String?
    /// 晚上风力
    var night: String?
   
    
    init(jsonData: JSON) {
        day = jsonData["day"].string
        night = jsonData["night"].string
    }
}
