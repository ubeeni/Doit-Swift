//
//  TextViewController.swift
//  PinchGesture
//
//  Created by 김유빈 on 2022/07/02.
//

import UIKit

class TextViewController: UIViewController {
    @IBOutlet var txtPinch: UILabel!
    
    var initialFontSize:CGFloat! // 글자 크기를 저장하기 위한 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIPinchGestureRecognizer 클래스 상수 pinch 선언
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(TextViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch) // 핀치 제스처 등록
    }
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // 핀치 제스처 상태 확인
        if (pinch.state == UIGestureRecognizer.State.began) {
            // 시작 상태이면 현재 글자 크기를 저장
            initialFontSize = txtPinch.font.pointSize
        } else {
            // 시작 상태가 아니면 텍스트의 글자 크기를 변경
            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale)
        }
    }
}

