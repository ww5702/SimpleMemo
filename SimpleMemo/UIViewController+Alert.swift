//
//  UIViewController+Alert.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/29.
//

import UIKit

extension UIViewController {
    func alert(title:String = "알림", message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)       // alertview나 actionsheet 둘다 똑같이 생성
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
