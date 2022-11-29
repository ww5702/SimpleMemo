//
//  ComposeViewController.swift
//  SimpleMemo
//
//  Created by 이재웅 on 2022/11/29.
//

import UIKit

class ComposeViewController: UIViewController {
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
    }
    
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
