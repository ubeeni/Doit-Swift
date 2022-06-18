//
//  ViewController.swift
//  Map
//
//  Created by 김유빈 on 2022/06/18.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        // 위치 정보를 표시할 레이블에는 아직 특별히 표시할 필요가 없으므로 공백으로 두기
        locationManager.delegate = self // 상수 locationManager의 델리게이트를 self로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치 데이터를 추적하기 위해 사용자에게 승인 요구
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 위치 보기 값을 true로 설정
    }

    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        // 위도 값과 경도 값을 매개변수로 하여 CLLocationCoordinate2DMake 함수를 호출하고, 리턴 값을 pLocation으로 받음
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true) // pRegion 값을 매개변수로 하여 myMap.setRegion 함수 호출
        return pLocation
    }
    
    // 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle:String) {
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotaion.title = strTitle
        annotaion.subtitle = strSubtitle
        myMap.addAnnotation(annotaion)
    }
    
    // 위치 정보에서 국가, 지역, 도로를 추출하여 레이블에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 업데이트되면 먼저 마지막 위치 값을 찾아냄
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        // 마지막 위치의 위도와 경도 값을 가지고 앞에서 만든 goLocation 함수 호출
        // delta 값 : 지도의 크기를 정함 -> 값이 작을수록 확대되는 효과
        // delta: 0.01 -> 1의 값보다 지도를 100배로 확대해서 보여 줌
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        locationManager.stopUpdatingLocation()
    }
    
    // 세그먼트 컨트롤을 선택하였을 때 호출
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // "현재 위치" 선택 - 현재 위치 표시
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            // "폴리텍대학" 선택 - 핀을 설치하고 위치 정보 표시
            setAnnotation(latitudeValue: 37.751853, longitudeValue: 128.87605740000004, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "한국폴리텍대학 강릉캠퍼스"
        } else if sender.selectedSegmentIndex == 2 {
            // "이지스퍼블리싱" 선택 - 핀을 설치하고 위치 정보 표시
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "이지스퍼블리싱 출판사"
        }
    }
    
}

