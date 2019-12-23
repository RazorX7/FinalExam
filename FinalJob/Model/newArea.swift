//
//  newArea.swift
//  NJU
//
//  Created by naive on 2019/12/23.
//  Copyright © 2019 linnaXie. All rights reserved.
//

import Foundation

class newArea{
    
    var areaName:String?
    var areaChild = [newsCell]()
    var numOfChild = 0
    
    init(areaName:String){
        self.areaName = areaName
    }
    
    func addChild(titles:[String],urls:[String],dates:[String],hots:[String]) {
        let sum = titles.count
        //因为在html里面hot的存储是（10）这样的格式，所以需要做字符串解析
        for i in 0...sum{
            var hot = hots[i]
            hot = hot.replacingOccurrences(of: "(", with: "")
            hot = hot.replacingOccurrences(of: ")", with: "")
            let cell = newsCell(title: titles[i], data: dates[i], previewURL: urls[i], hot: Int(hot)!)
            self.areaChild.append(cell)
        }
        self.numOfChild = sum
    }
}
