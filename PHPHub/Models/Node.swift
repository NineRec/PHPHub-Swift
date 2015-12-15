//
//  Node.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/15.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import SwiftyJSON

final class Node: ResponseObjectSerializable{
    let nodeId: Int
    let nodeName: String
    let parentNode: Int
    
    init?(jsonData: JSON) {
        nodeId = jsonData["id"].intValue
        nodeName = jsonData["name"].stringValue
        parentNode = jsonData["parent_node"].intValue
    }
}
