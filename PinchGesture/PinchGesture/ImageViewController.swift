//
//  ImageViewController.swift
//  PinchGesture
//
//  Created by 김유빈 on 2022/07/02.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var imgPinch: UIImageView!
    
    var initialFontSize:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ImageViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }

    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        // 이미지를 스케일에 맞게 변환
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        
        // 다음 변환을 위해 핀치의 스케일 속성을 1로 설정
        pinch.scale = 1
    }
}
