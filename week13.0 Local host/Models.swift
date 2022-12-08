import Foundation
import SwiftUI

struct DataModel:Codable{
    let error:Bool
    let message:String
    let data:[PostModel]
}

struct PostModel:Codable{
    let id :UUID
    let title:String
    let content:String
    
}
