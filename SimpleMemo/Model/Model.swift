//
//  Model.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/25.
//

import Foundation

class Memo {
    // 내용과 날짜
    var content: String
    var insertData: Data
    
    init(content: String) {
        self.content = content
        insertData = Data()     // Data() = 현재날짜
    }
    
    // 일단 더미로
    static var dummyMemoList = [
        Memo(content: "Lorem Ipsum"),
        Memo(content: "😃😃😃😃😃")
    ]
    
    
}
