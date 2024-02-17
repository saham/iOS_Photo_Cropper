import Foundation
struct User:Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case job
        case membership
        case location
        case phone
        case profilePhoto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.job = try container.decode(String.self, forKey: .job)
        self.membership = try container.decode(String.self, forKey: .membership)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.profilePhoto = try container.decode(String.self, forKey: .profilePhoto)
    }
    var name:String
    var job:String
    var membership:String
    var location:String?
    var phone:String
    var profilePhoto:String
}

