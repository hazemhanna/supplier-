//
//  HomeModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ObjectMapper

final class HomeModel: BaseObject {
    
    var sliders: [SliderModel] = []
    var posts: [PostModel] = []
    var promotionsList: [PromotionModel] = []
    var trendingProducts: [TrendingProductModel] = []
    var categories: [CategoryModel] = []

    override func mapping(map: Map) {
        super.mapping(map: map)
        sliders <- map["slider"]
        posts <- map["posts"]
        promotionsList <- map["promotions_list"]
        trendingProducts <- map["trending_products"]
        categories <- map["categories"]
    }
    
}
