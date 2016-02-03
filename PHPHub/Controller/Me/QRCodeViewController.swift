//
//  QRCodeViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/24.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import SwiftQRCode

class QRCodeViewController: UIViewController {
    lazy var scanner = QRCode()
    var completion: ((success: Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scanner.prepareScan(view) { stringValue in
            let loginInfo = stringValue.characters.split{$0 == ","}.map{String($0)}
            
            if loginInfo.count == 2 {
                CurrentUserHandler.defaultHandler.login(username: loginInfo[0], loginToken: loginInfo[1], callback: self.completion!)
                debugPrint("QRCodeViewController")
            } else {
                self.noticeInfo("扫描的二维码不能识别呢", autoClear: true)
            }
            
            self.scanner.stopScan()
            self.navigationController?.popViewControllerAnimated(true)
        }
        scanner.scanFrame = view.bounds
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        scanner.startScan()
    }
}
