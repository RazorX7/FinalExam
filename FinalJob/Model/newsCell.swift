//
//  newsCell.swift
//  NJU
//
//  Created by naive on 2019/12/23.
//  Copyright © 2019 linnaXie. All rights reserved.
//

import Foundation

class newsCell{
    let title:String
    let date:String
    let previewURL:String
    let hot:Int
    
    init(title:String,data:String,previewURL:String,hot:Int) {
        self.title = title
        self.date = data
        self.previewURL = previewURL
        self.hot = hot
    }
}
