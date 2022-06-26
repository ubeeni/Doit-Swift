//
//  DetailViewController.swift
//  Table
//
//  Created by 김유빈 on 2022/06/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    var receiveItem = ""

    @IBOutlet var lblItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblItem.text = receiveItem
    }
    
    // Main View에서 변수를 받아오기 위한 함수
    func reciveItem(_ item: String)
    {
        receiveItem = item
    }
    
}
