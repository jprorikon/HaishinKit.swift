import Foundation

public struct MoQTObject {
    /// 7.1.1.1.  Object Status
    public enum Status: Int, Sendable {
        /// Indicates Object does not exist.
        case normal = 0x0
        /// Indicates Object does not exist.
        case notExist = 0x1
        /// Indicates end of Group.
        case endOfGroup = 0x3
        /// Indicates end of Track and Group.
        case endOfTrackGroup = 0x4
        /// Indicates end of Subgroup.
        case endOfSubgroup = 0x5
    }

    public let id: Int
    public let status: Status?
    public let data: Data

    var payload: Data {
        get throws {
            var payload = MoQTPayload()
            payload.putInt(id)
            payload.putInt(data.count)
            if let status {
                payload.putInt(status.rawValue)
            }
            payload.putData(data)
            return payload.data
        }
    }
}

extension MoQTObject {
    init(_ payload: inout MoQTPayload) throws {
        id = try payload.getInt()
        let length = try payload.getInt()
        status = length == 0 ? Status(rawValue: try payload.getInt()) : nil
        self.data = try payload.getData(length)
    }
}
