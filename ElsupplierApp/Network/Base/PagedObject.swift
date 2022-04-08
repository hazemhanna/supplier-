//
//  KPagedObject.swift
//
//  Created by Ahmed Madeh.
//

import ObjectMapper

class PagedObject<T: BaseObject>: Mappable {
    
    var items: [T] = []
    var totalCount = 0
    var skip: Int { return items.count }
    var pageSize = 16
    var nextPage: Int {
           return Int(items.count / pageSize) + 1
    }
    init() { }
    required init?(map: Map) { }
    func mapping(map: Map) {
        items <- map["products"]
        totalCount <- map["pagination.total"]
        pageSize <- map["pagination.size"]
    }
    func hasNext(_ indexPath: IndexPath) -> Bool {
        return items.count < totalCount && indexPath.row == items.count - 1
    }
}
