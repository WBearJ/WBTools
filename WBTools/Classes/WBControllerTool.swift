//
//  ControllerTool.swift
//  IMChats
//

import UIKit

class WBControllerTool: NSObject {
    
    /// 获取当前viewController
    public class func currentViewController() -> UIViewController? {
        
        var rootViewController: UIViewController!
        
        // 获取 rootViewController
        if #available(iOS 13.0, *) {
            guard let scene = UIApplication.shared.connectedScenes.first,
                  let windowScene = (scene as? UIWindowScene),
                  let rootVC = windowScene.windows.first?.rootViewController else {
                return nil
            }
            rootViewController = rootVC
        } else {
            guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
                return nil
            }
            rootViewController = rootVC
        }
        
        // present
        if rootViewController.presentedViewController != nil {
           
            guard let presentedViewController = rootViewController.presentedViewController else {
                return nil
            }
            
            // navigationController
            if presentedViewController.isKind(of: UINavigationController.classForCoder()) {
               
                guard let navigationController: UINavigationController = presentedViewController as? UINavigationController else {
                    return nil
                }
                return navigationController.visibleViewController
            }
            
            // tabBarController
            if presentedViewController.isKind(of: UITabBarController.classForCoder()) {
               
                guard let tabBarController: UITabBarController = presentedViewController as? UITabBarController,
                      let selectedViewController = tabBarController.selectedViewController else {
                    return nil
                }
                
                if selectedViewController.isKind(of: UINavigationController.classForCoder()) {
                    guard let navigationController: UINavigationController = selectedViewController as? UINavigationController  else {
                        return nil
                    }
                    return navigationController.visibleViewController
                }
                return selectedViewController
            }
            
            return presentedViewController
        }

        // 非 present
        // tabBarController
        if rootViewController.isKind(of: UITabBarController.classForCoder()) {

            guard let tabBarController: UITabBarController = rootViewController as? UITabBarController,
                  let selectedViewController = tabBarController.selectedViewController else {
                return nil
            }
            
            if selectedViewController.isKind(of: UINavigationController.classForCoder()) {
                guard let navigationController: UINavigationController = selectedViewController as? UINavigationController  else {
                    return nil
                }
                return navigationController.visibleViewController
            }
            return selectedViewController
        }

        // navigationController
        if rootViewController.isKind(of: UINavigationController.classForCoder()) {
            guard let navigationController: UINavigationController = rootViewController as? UINavigationController else {
                return nil
            }
            return navigationController.visibleViewController
        }
        
        return rootViewController
    }
}
