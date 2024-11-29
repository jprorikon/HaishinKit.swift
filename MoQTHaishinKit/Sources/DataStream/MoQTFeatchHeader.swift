public struct MoQTFeatchHeader: MoQTDataStream {
    public let type: MoQTDataStreamType = .fetchHeader
    public let subscribeId: Int
}
