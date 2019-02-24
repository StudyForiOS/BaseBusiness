//
//  Bus.swift
//  BaseBusiness
//
//  Created by ForJade Giant on 2019/2/24.
//

import UIKit


enum BusError: Error {
    case BusinessNil
}

open class Bus: NSObject {
    
    static let shareInstance = Bus()
    private var busDic = Dictionary<String, BaseBusiness>()
    static var busSpinLock = OS_SPINLOCK_INIT
    
    let busLock = NSLock()
    
    public class func register(business: BaseBusiness) {
        
        OSSpinLockLock(&busSpinLock)
        if (Bus.shareInstance.busDic[business.host] != nil) {
            assert(true, "bunengchongfuzhuce")
        }
        
        Bus.shareInstance.busDic[business.host] = business
        
        OSSpinLockUnlock(&busSpinLock)
        
    }
    
    public class func busObjectForName(_ busName: String) -> BaseBusiness? {
        
        OSSpinLockLock(&busSpinLock)
        
        var map = Bus.shareInstance.busDic
        
        let hostList = map.keys
        
        var findKey = ""
        
        hostList.forEach { (key: String) in
            if busName.lowercased().hasPrefix(key.lowercased()) {
                findKey = key
            }
        }
        
        let business = map[findKey]
        OSSpinLockUnlock(&busSpinLock)
        
        return business
    }
    
    public class func callData(_ busName: String,param: AnyObject...) throws -> Any {
        
        let baseBusiness = Bus .busObjectForName(busName)
        
        guard baseBusiness != nil else {
            throw BusError.BusinessNil
        }
        
        var params = Array<AnyObject>()
        
        var eachItem: AnyObject?
        
        var argumentList: va_list?
        
//        if param != nil {
//            var paramArray = Array<AnyObject>()
//            paramArray.append(param as AnyObject)
//            va_start(argumentList,param)
//
//
//        }
        
        
        
        return "nil"
    }

}
