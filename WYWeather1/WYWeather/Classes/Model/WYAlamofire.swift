//
//  WYAlamofire.swift
//  WYWeather
//
//  Created by study on 2019/7/2.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import IHProgressHUD

typealias JSON = SwiftyJSON.JSON

//json -> model 转换需要遵守的协议
protocol JSONCoverible {
    static func fromJSON(json: JSON?) -> Self?
}

/// 第三方网络请求框架 Alamofire
struct WYAlamofire {
    
    static func api(url: String, parameters: Parameters?, success:@escaping (_ json: Any) -> Void , failed: @escaping (Error) -> Void){
        
        IHProgressHUD.showInfowithStatus("正在加载中...")
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON(options: .allowFragments) { response in
                
                IHProgressHUD.dismiss()
                
                switch response.result {
                case .failure(let error):
                    
                    print("error = \(error)")
                    failed(error)
                    
                case .success(let json):
                     success(json)
                }
                
        }
    }
}
