import Foundation

public struct MoQTStreamHeaderSubgroup: MoQTDataStream {
    public let type: MoQTDataStreamType = .streamHeaderSubgroup
    public let trackAlias: Int
    public let groupId: Int
    public let subgroupId: Int
    public let publisherPriority: Int

    public var payload: Data {
        get throws {
            var payload = MoQTPayload()
            payload.putInt(type.rawValue)
            payload.putInt(trackAlias)
            payload.putInt(groupId)
            payload.putInt(subgroupId)
            payload.putInt(publisherPriority)
            return payload.data
        }
    }
}

extension MoQTStreamHeaderSubgroup {
    init(_ payload: inout MoQTPayload) throws {
        trackAlias = try payload.getInt()
        groupId = try payload.getInt()
        subgroupId = try payload.getInt()
        publisherPriority = try payload.getInt()
    }
}
