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
    public static func archiveObjects<T: WBArchivable>(lists: [T], fileName: String) -> Bool {
        guard let archivePath = documentDirtory(fileName) else {
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

    public static func unarchiveObjects<T: WBArchivable>(fileName: String) -> [T]? {
        guard let archivePath = documentDirtory(fileName) else {
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
    public static func archiveObject<T: WBArchivable>(object: T, fileName: String) -> Bool {
        guard let archivePath = documentDirtory(fileName) else {
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

    public static func unarchiveObject<T: WBArchivable>(fileName: String) -> T? {
        guard let archivePath = documentDirtory(fileName) else {
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
    
    /// 删除归档文件
    /// - Parameter file: 文件名
    /// - Returns: 结果
    public static func deleteArchiveObjects(fileName: String) -> Bool {
        guard let archivePath = documentDirtory(fileName) else {
            return false
        }
        do {
            try FileManager.default.removeItem(atPath: archivePath)
            return true
        } catch {
            return false
        }
        
    }
}
