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
    
    // 편집 이전의 내용을 저장
    var originalMemoContent: String?
    
    
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
    
    var willShowToken: NSObjectProtocol?
    var willHideToken: NSObjectProtocol?
    
    deinit {
        if let token = willShowToken {
            NotificationCenter.default.removeObserver(token)
        }
        
        if let token = willHideToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기화되는 코드는 여기서 구현
        // 편집모드 이라면 if문구 실행
        if let memo = editTarget {
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
            originalMemoContent = memo.content
        } else {
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }
        
        memoTextView.delegate = self
        
        // 메모 작성시 키보드만큼의 여백 자동표시
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            guard let strongSelf = self else {return}
            
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = frame.cgRectValue.height
                
                var inset = strongSelf.memoTextView.contentInset
                inset.bottom = height
                strongSelf.memoTextView.contentInset = inset
                 
                inset = strongSelf.memoTextView.scrollIndicatorInsets
                inset.bottom = height
                strongSelf.memoTextView.scrollIndicatorInsets = inset
            }
        })
        
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in guard let strongSelf = self else {return}
            
            var inset = strongSelf.memoTextView.contentInset
            inset.bottom = 0
            strongSelf.memoTextView.contentInset = inset
            
            inset = strongSelf.memoTextView.scrollIndicatorInsets
            inset.bottom = 0
            strongSelf.memoTextView.scrollIndicatorInsets = inset
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 메모 작성시 자동으로 키보드 출현
        memoTextView.becomeFirstResponder()
        
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 키보드 자동 사라짐
        memoTextView.resignFirstResponder()
        
        navigationController?.presentationController?.delegate = nil
        
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

extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let original = originalMemoContent, let edited = textView.text {
            // textview에서 원본을 편집할때마다 원본과 비교한다음 원본과 다르다면 편집된거로 간주
            isModalInPresentation = original != edited
            
        }
    }
}

// 여기서 원본과 편집된 데이터가 다르다면 alert 실행
extension ComposeViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) {[weak self] (action) in
            self?.save(action)
        }
        alert.addAction(okAction)
        
        // 취소 액션
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) {[weak self] (action) in
            self?.close(action)
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension ComposeViewController {
    // notification은 라디오방송이라고 생각하면 편하다
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
