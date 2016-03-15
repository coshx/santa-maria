class ResponsivenessBenchmarkData {
    private static let seed = [
        "_id": "56e8776b732464925948075b",
        "index": 0,
        "guid": "2f872a04-c082-49cb-869a-6303f01c321b",
        "isActive": false,
        "balance": "$1,841.07",
        "picture": "http://placehold.it/32x32",
        "age": 24,
        "eyeColor": "brown",
        "name": "Leslie Decker",
        "gender": "female",
        "company": "MUSANPOLY",
        "email": "lesliedecker@musanpoly.com",
        "phone": "+1 (963) 476-3189",
        "address": "314 Tabor Court, Breinigsville, Vermont, 3665",
        "about": "Qui non mollit commodo enim consequat mollit fugiat officia esse elit. Dolor nulla ad Lorem deserunt minim cupidatat officia ea nostrud sint excepteur aliquip nisi reprehenderit. Elit quis cillum et cillum ipsum est ad adipisicing elit ut do quis nostrud.\r\n",
        "registered": "2015-03-30T09:35:39 +07:00",
        "latitude": 67.626078,
        "longitude": -178.242011,
        "tags": [
            "exercitation",
            "laboris",
            "laboris",
            "deserunt",
            "consectetur",
            "aliqua",
            "occaecat"
        ],
        "friends": [
            [
                "id": 0,
                "name": "Imelda Petty"
            ],
            [
                "id": 1,
                "name": "Chambers Diaz"
            ],
            [
                "id": 2,
                "name": "Craft Quinn"
            ]
        ],
        "greeting": "Hello, Leslie Decker! You have 6 unread messages.",
        "favoriteFruit": "apple"
    ]

    static func generate(length: Int) -> [AnyObject] {
        var outcome = [AnyObject]()

        for _ in 0 ..< length {
            outcome.append(seed)
        }

        return outcome
    }
}