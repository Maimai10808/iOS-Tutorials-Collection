//
//  UploadImageAndPostViewController.swift
//  SocialNetworkingApp
//
//  Created by mac on 7/24/25.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class UploadImageAndPostViewController: UIViewController {
    
    
    @IBOutlet weak var progrssView: UIProgressView!
    
    var postToUpload: PostToUpload!
    var uploadTask: StorageUploadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImage()
    }
    
    func uploadImage() {
        // 压缩图片并转为 JPEG data
        guard let image = postToUpload.image,
              let imageData = image.jpegData(compressionQuality: 0.7),
              !imageData.isEmpty else {
            presentError(title: "图片错误", message: "请选择有效的图片")
            return
        }

        // 获取当前用户 UID
        guard let userId = Auth.auth().currentUser?.uid else {
            presentError(title: "未登录", message: "请登录后再上传")
            return
        }

        // 构建路径
        let imageID = UUID().uuidString.replacingOccurrences(of: "-", with: "_").lowercased()
        let imageName = "\(imageID).jpeg"
        let imagePath = "images/\(userId)/\(imageName)"
        
        // Firebase Storage 引用（确保使用 gs:// 的初始化方式）
        let storage = Storage.storage()
        let reference = storage.reference(withPath: imagePath)
        
        // 上传元信息
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // 初始化上传进度
        progrssView.progress = 0

        // 开始上传
        let uploadTask = reference.putData(imageData, metadata: metadata)

        // 上传进度监听
        uploadTask.observe(.progress) { [weak self] snapshot in
            guard let self = self else { return }
            let percent = Float(snapshot.progress?.fractionCompleted ?? 0)
            DispatchQueue.main.async {
                self.progrssView.setProgress(percent, animated: true)
            }
        }

        // 上传完成后
        uploadTask.observe(.success) { [weak self] _ in
            guard let self = self else { return }

            // 上传成功后再确认 metadata
            reference.getMetadata { metadata, error in
                if let error = error {
                    self.presentError(title: "确认失败", message: "图片上传未能验证: \(error.localizedDescription)")
                    return
                }

                // 成功后获取下载地址
                reference.downloadURL { url, error in
                    if let error = error {
                        self.presentError(title: "获取URL失败", message: error.localizedDescription)
                        return
                    }

                    guard let downloadURL = url?.absoluteString else {
                        self.presentError(title: "无效URL", message: "未能生成图片地址")
                        return
                    }

                    // 写入 Firestore
                    let postData: [String: Any] = [
                        "imageURL": downloadURL,
                        "description": self.postToUpload.posttext,
                        "userId": userId,
                        "createdAt": Date().timeIntervalSince1970
                    ]

                    Firestore.firestore().collection("posts").document().setData(postData) { error in
                        if let error = error {
                            self.presentError(title: "上传失败", message: error.localizedDescription)
                            return
                        }
                        self.dismiss(animated: true)
                    }
                }
            }
        }

        // 上传失败
        uploadTask.observe(.failure) { [weak self] snapshot in
            guard let self = self else { return }
            if let error = snapshot.error as NSError? {
                self.presentError(title: "上传错误", message: error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        uploadTask?.cancel()
    }
    

}
