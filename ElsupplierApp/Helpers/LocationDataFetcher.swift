//
//  LocationDataFetcher.swift
//
//  Created by Ahmed Madeh.
//


import UIKit
//import PromiseKit

//final class LocationDataFetcher {
//    static let shared = LocationDataFetcher()
//    fileprivate var imageCache: [String: UIImage] = [:]
//    fileprivate var textCache: [String: String] = [:]
//    private init (){ }
//
//    lazy var operationQueue: OperationQueue = {
//        var queue = OperationQueue()
//        queue.name = "LocationDataFetcher queue"
//        queue.maxConcurrentOperationCount = 10
//        return queue
//    }()
//
//    func imageCache(latitude: Double, longitude: Double) -> UIImage? {
//        return imageCache["\(latitude)_\(longitude)"]
//    }
//
//    func textCache(latitude: Double, longitude: Double) -> String? {
//        return textCache["\(latitude)_\(longitude)"]
//    }
//
//    func cache(image: UIImage, latitude: Double, longitude: Double) {
//         imageCache["\(latitude)_\(longitude)"] = image
//    }
//
//    func cache(text: String, latitude: Double, longitude: Double) {
//         textCache["\(latitude)_\(longitude)"] = text
//    }
//
//    static func getImageSnapShot(_ latitude: Double, longitude: Double) -> Promise<UIImage> {
//        return .init { resolver in
//            MapUtil.requestScreenShot(at: .init(latitude: latitude, longitude: longitude)) { (snapShot, error) in
//                guard let image = snapShot?.image else {
//                    return resolver.reject(error ?? NSError.init(error: "an error occured", code: -1))
//                }
//                return resolver.fulfill(image)
//            }
//        }
//    }
//
//    static func getAddress(_ latitude: Double,_ longitude: Double) -> Promise<String> {
//        return .init { resolver in
//            MapUtil.requestAddressFrom(location: .init(latitude: latitude, longitude: longitude)) { (address, error) in
//                guard let address = address else {
//                    return resolver.reject(error ?? NSError.init(error: "an error occured", code: -1))
//                }
//                return resolver.fulfill(address)
//            }
//        }
//    }
//}


//class ViewOperation<View: UIView, Value>: Operation {
//    fileprivate let source: Promise<Value>
//    fileprivate let completion: (_ view: View,_ value: Value) -> Void
//    weak var view: View?
//    
//    init(_ source: Promise<Value>, completion: @escaping (_ view: View,_ value: Value) -> Void) {
//        self.source = source
//        self.completion = completion
//    }
//    
//    override func main() {
//        if isCancelled { return }
//        onStart()
//        source.done { value in
//            guard let view = self.view else { return }
//            self.completion(view, value)
//        }.catch { error in
//            print(error.localizedDescription)
//            
//        }.finally { [weak self] in
//            guard let self = self else { return }
//            self.onFinish()
//        }
//    }
//    
//    func onStart() { }
//    func onFinish() { }
//}

//class SnapShotOperation: ViewOperation<UIImageView, UIImage> {
//    let latitude: Double
//    let longitude: Double
//
//    init(latitude: Double, longitude: Double) {
//        self.latitude = latitude
//        self.longitude = longitude
//        super.init(LocationDataFetcher.getImageSnapShot(latitude, longitude: longitude)) { (imageView, image) in
//            imageView.image = image
//            imageView.removeActivityindicator()
//            LocationDataFetcher.shared.cache(image: image, latitude: latitude, longitude: longitude)
//        }
//    }
//    override  func onStart()  {
//        DispatchQueue.main.async {
//            self.view?.addActivityindicator()
//        }
//    }
//
//    override func onFinish()  {
//        DispatchQueue.main.async {
//            self.view?.removeActivityindicator()
//        }
//    }
//}

//class AddressOperation: ViewOperation<UILabel, String> {
//    let latitude: Double
//    let longitude: Double
//
//    init(latitude: Double, longitude: Double) {
//        self.latitude = latitude
//        self.longitude = longitude
//        super.init(LocationDataFetcher.getAddress(latitude, longitude)) { (label, text) in
//            label.text = text
//            LocationDataFetcher.shared.cache(text: text, latitude: latitude, longitude: longitude)
//        }
//    }
//}

//extension UILabel {
//    func setAddress(latitude: Double, longitude: Double) {
//        let fecher = LocationDataFetcher.shared
//        if let cache = fecher.textCache(latitude: latitude, longitude: longitude) {
//            return text = cache
//        }
//        text = "loading"
//        if let operations = fecher.operationQueue.operations.filter({$0 is AddressOperation}) as? [AddressOperation],
//           let operation = operations.first(where: {$0.latitude == latitude && $0.longitude == longitude }) {
//            return operation.view = self
//        }
//        let operation = AddressOperation.init(latitude: latitude, longitude: longitude)
//        operation.view = self
//        fecher.operationQueue.addOperation(operation)
//    }
//}

//extension UIImageView {
//    func setLocationSnapShot(_ latitude:  Double, longitude: Double){
//        let fecher = LocationDataFetcher.shared
//        if let cache = fecher.imageCache(latitude: latitude, longitude: longitude) {
//            removeActivityindicator()
//            return image = cache
//        }
//
//        image = nil
//        if let operations = fecher.operationQueue.operations.filter({$0 is SnapShotOperation}) as? [SnapShotOperation],
//           let operation = operations.first(where: {$0.latitude == latitude && $0.longitude == longitude }) {
//            addActivityindicator()
//            return operation.view = self
//        }
//        let operation = SnapShotOperation.init(latitude: latitude, longitude: longitude)
//        operation.view = self
//        fecher.operationQueue.addOperation(operation)
//    }
//}
