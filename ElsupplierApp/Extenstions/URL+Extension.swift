//
//  URL+Extension.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/07/2022.
//

import MobileCoreServices
import Foundation

extension URL {
    func mimeType() -> String {
         let pathExtension = self.pathExtension
         if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
             if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
             }
         }
         return "application/octet-stream"
    }

    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
             return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }

    var containsAudio: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
              return false
        }
        return UTTypeConformsTo(uti, kUTTypeAudio)
    }
    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
               return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie) || UTTypeConformsTo(uti, kUTTypeVideo)
    }
 }
