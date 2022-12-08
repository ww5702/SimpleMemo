//
//  ComposeViewController.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/29.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // 보기에서 편집을 탭하면 여기로 메모가 저장
    var editTarget: Memo?
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        
        guard let memo = memoTextView.text, memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            return
        }
        
//        let newMemo = Memo(content: memo)
//        Memo.dummyMemoList.append(newMemo)
        
        if let target = editTarget {
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memoDidChange, object: nil)
            
        } else {
            // 쓰기모드라면 전의 코드를 그대로 수행
            DataManager.shared.addNewMemo(memo)
            
            // 자동으로 테이블 목록을 업데이트 시켜주지않음
            // 따라서 Notification
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
        }
    
        
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기화되는 코드는 여기서 구현
        if let memo = editTarget {
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
        } else {
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ComposeViewController {
    // notification은 라디오방송이라고 생각하면 편하다
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
