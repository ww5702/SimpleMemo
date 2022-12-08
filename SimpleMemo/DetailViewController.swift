//
//  DetailViewController.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/29.
//

import UIKit

class DetailViewController: UIViewController {

    // 메모 저장
    @IBOutlet weak var memoTableView: UITableView!
    var memo: Memo?
    
    let formatter: DateFormatter = {
       let f = DateFormatter()
        f.dateStyle = .long         // 연도 월 일, 표시하려면 long 표시하지 않으려면 short
        f.timeStyle = .short        // 시 분 초
        // f.locale = Locale(identifier: "Ko_kr")   날짜와 시간이 한글로 나오지 않는다면 설정
        return f
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = memo
        }
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 수정된 메모를 저장하자마자 바로 표시
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoDidChange, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in self?.memoTableView.reloadData()})
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

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:     // 첫번째 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            
            cell.textLabel?.text = memo?.content
            
            return cell
        
        case 1:     // 두번째 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            
            return cell
            
        default:
            fatalError()
            
        }
        
    }
    
    
}
