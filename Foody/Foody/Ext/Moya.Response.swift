//
//  Moya.ResponseExt.swift
//  Foody
//
//  Created by MBA0283F on 4/8/21.
//

import Moya

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
