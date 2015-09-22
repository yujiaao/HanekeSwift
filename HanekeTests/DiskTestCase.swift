//
//  DiskTestCase.swift
//  Haneke
//
//  Created by Hermes Pique on 8/26/14.
//  Copyright (c) 2014 Haneke. All rights reserved.
//

import XCTest

class DiskTestCase : XCTestCase {
 
    lazy var directoryPath : String = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] 
        let directoryPath = NSURL(string: documentsPath)!.URLByAppendingPathComponent(self.name)
        return directoryPath.absoluteString
    }()
    
    override func setUp() {
        super.setUp()
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(directoryPath, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
        }
    }
    
    override func tearDown() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(directoryPath)
        } catch _ {
        }
        super.tearDown()
    }
    
    var dataIndex = 0
    
    func writeDataWithLength(length : Int) -> String {
        let data = NSData.dataWithLength(length)
        return self.writeData(data)
    }
    
    func writeData(data : NSData) -> String {
        let path = self.uniquePath()
        data.writeToFile(path, atomically: true)
        return path
    }
    
    func uniquePath() -> String {
        let path = NSURL(string:self.directoryPath)!.URLByAppendingPathComponent("\(dataIndex)")
        dataIndex++
        return path.absoluteString
    }
    
}
