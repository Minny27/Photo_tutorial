//
//  ViewController.swift
//  Photo_tutorial
//
//  Created by SeungMin on 2021/04/13.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileChangeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 이미지를 동그랗게 만들 때 frame.height / 2 쓰기
        self.profileImage.layer.cornerRadius = profileImage.frame.height / 2
        self.profileChangeBtn.layer.cornerRadius = 10
        // 이벤트를 생성하는 두 번째 방법
        // 뷰가 생성됨과
        // 클릭이 일어났을 때 실행시킬 메소드를 action에 정하기
        self.profileChangeBtn.addTarget(self, action: #selector(onProfileChangeBtnClicked), for: .touchUpInside)
    }
    
    // 프사변경하기 버튼을 클릭했을 때
    @objc fileprivate func onProfileChangeBtnClicked() {
        print("ViewController - onProfileChangeBtnClicked() called")
        
        // Here we configure the picker to only show videos, no photos.
        // 카메라 라이브러리 세팅
        var config = YPImagePickerConfiguration()
//        config.screens = [.library, .photo, .video]
        config.screens = [.library]
//        config.library.mediaType = .video

        // 사진이 선택 되었을 때
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by t e user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                self.profileImage.image = photo.image
            }
            // 사진 선택창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        // 사진 선택창 보여주기
        present(picker, animated: true, completion: nil)
        
    }


}

