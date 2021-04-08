//
//  FirebaseStorage.swift
//  Foody
//
//  Created by MBA0283F on 4/7/21.
//

import FirebaseStorage

extension FirebaseManager.Storage {
    
    func uploadImages() {
        let storage = Storage.storage(url: "gs://food-app-30a00.appspot.com/")
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images/mountains.jpg")
        
        imagesRef.putData(Data(), metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
              // You can also access to download URL after upload.
            imagesRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
            }
        }
    }
}
