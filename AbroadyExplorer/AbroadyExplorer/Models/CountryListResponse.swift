import Foundation

// The "envelope" REST Countries wraps around every list:
// { "data": { "objects": [ ...countries... ], "meta": { "more": true, ... } } }
// We decode the envelope first, then take the countries out of data.objects.
struct CountryListResponse: Codable {
    let data: ResponseData

    struct ResponseData: Codable {
        let objects: [Country]
        let meta: Meta?
    }

    // Paging info: `more` is true while there are still countries left to download.
    struct Meta: Codable {
        let total: Int?
        let count: Int?
        let limit: Int?
        let offset: Int?
        let more: Bool?
    }
}
