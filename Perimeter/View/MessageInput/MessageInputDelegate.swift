//
//  MessageInputDelegate.swift
//  Perimeter
//
//  Created by Davone Barrett on 10/25/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

protocol MessageInputDelegate: AnyObject {
    func userDidPressSendButton(message: String?)
    func userDidPressCameraButton() -> UIImage?
}
