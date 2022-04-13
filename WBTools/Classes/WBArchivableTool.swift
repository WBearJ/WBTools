//
//  WBArchivableTool.swift
//  WBTools
//
//  Created by WBear on 2022/4/13.
//

import Foundation

public protocol WBArchivable {
    var archive: NSDictionary { get }
    init?(unarchive: NSDictionary?)
}

public struct WBArchivableTool {
    public static func documentDirtory(_ file: String) -> String? {
        //document文件夹
        guard let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first else {
            return nil
        }
        return documentDir + "/" + file
    }
    
    //MARK: ============= objects archive
    
    @discardableResult
    public static func archiveObjects<T: WBArchivable>(lists: [T], file: String) -> Bool {
        guard let archivePath = documentDirtory(file) else {
            return false
        }
        
        let encodedLists = lists.map{ $0.archive }
        do {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: encodedLists, requiringSecureCoding: false)
            try data?.write(to: URL(fileURLWithPath: archivePath))
            return true
        }catch {
            print(error)
            return false
        }
    }

    public static func unarchiveObjects<T: WBArchivable>(file: String) -> [T]? {
        guard let archivePath = documentDirtory(file) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: archivePath))
            let list = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            guard let decodedLists = list as? [NSDictionary] else {
                return nil
            }
            return decodedLists.compactMap { return T(unarchive: $0) }
        }catch {
            return nil
        }
    }
    
    //MARK: ================= object archive
    @discardableResult
    public static func archiveObject<T: WBArchivable>(object: T, file: String) -> Bool {
        guard let archivePath = documentDirtory(file) else {
            return false
        }
        
        do {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: object.archive, requiringSecureCoding: false)
            try data?.write(to: URL(fileURLWithPath: archivePath))
            return true
        }catch {
            print(error)
            return false
        }
    }

    public static func unarchiveObject<T: WBArchivable>(file: String) -> T? {
        guard let archivePath = documentDirtory(file) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: archivePath))
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            guard let jsonDic = object as? NSDictionary else {
                return nil
            }
            return T(unarchive: jsonDic)
        }catch {
            return nil
        }
    }
}
