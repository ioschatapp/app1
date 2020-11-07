//
//  Global.swift
//  medical
//
//  Created by Y YM on 2020/11/6.
//  Copyright © 2020 edu. All rights reserved.
//

import Foundation

struct Global {
    static var USER_INFO: User? = nil
}

protocol Action {
    func onAction() -> Void
}
