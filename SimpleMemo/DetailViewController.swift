//
//  DetailViewController.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/29.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            return cell
        
        case 1:     // 두번째 셀
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            return cell
            
        default:
            fatalError()
            
        }
        
    }
    
    
}
