//
//  ImageSaver.swift
//  Stellar
//
//  Created by Elliot Knight on 03/08/2022.
//


import UIKit

class ImageSaver: NSObject {
	func writeToPhotoAlbum(image: UIImage) {
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
	}



	@objc func saveCompleted(_ image: UIImage, didFinishSaveError error: Error?, contextInfo: UnsafeRawPointer) -> Bool {
		return true
	}

}
