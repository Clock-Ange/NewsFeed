//
//  Post.swift
//  TestTask
//
//  Created by Геннадий Махмудов on 21.09.2020.
//

import Foundation

struct LoadedData: Codable {
    
    let data: NewData
}

struct NewData: Codable {
    var items = [Item]()
    var cursor: String?
}

struct Item: Codable {
    
    var id: String
    var contents = [Content]()
    var author: Author?
    var createdAt: Int
    var stats: Stats
}
struct Stats: Codable {
    let likes: Like
    let comments: Comment
}
struct Like: Codable {
    let count: Int
}
struct Comment: Codable {
    let count: Int
}
struct Content: Codable {
    
    let type: String
    let data: ContentData
}
struct Author: Codable{
    let name: String
    let photo: Content?
}

struct ContentData: Codable{
    
    let original: Original?
    let value: String?
    let values: [String]?
    let small: Small?
}

struct Small: Codable {
    let url: String
}
struct Original: Codable {
    let url: String
}

//struct Stats: Codable {
//
//}

//"data": {
//    "items": [
//      {
//        "id": "p:6TDEylOXoN",
//        "replyOnPostId": null,
//        "type": "PLAIN",
//        "status": "PUBLISHED",
//        "hidingReason": null,
//        "coordinates": {
//          "latitude": 49.37457510530924,
//          "longitude": 30.98633157791196,
//          "zoom": null
//        },
//        "isCommentable": true,
//        "hasAdultContent": false,
//        "isAuthorHidden": false,
//        "isHiddenInProfile": false,
//        "contents": [
//          {
//            "type": "IMAGE",
//            "id": "76/32/cwxz4J3vxSQd6x49vq-5c.AwCgAKAAQAFAAQ.jpeg",
//            "data": {
//              "extraSmall": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/76/32/cwxz4J3vxSQd6x49vq-5c_160x160.jpeg",
//                "size": {
//                  "width": 160,
//                  "height": 160
//                }
//              },
//              "small": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/76/32/cwxz4J3vxSQd6x49vq-5c_320x320.jpeg",
//                "size": {
//                  "width": 320,
//                  "height": 320
//                }
//              }
//            }
//          },
//          {
//            "type": "TEXT",
//            "data": {
//              "value": "Salve народ! И я туда же...\nХочу познакомиться с человеком для общения!\nЕсли коротко о себе, то я парень 18 лет тип характера, еммм, ну где то между флегматиком и сангвиником, не страдаю апатией и тоской (немного не стандартно для пользователя анонима :)) Общение, хмм.. Ну здесь даже не знаю все чего я знаю, в общем подержать разговор могу. Живу на окраине города, где не очень то и много развлечений как и людей, способных подержать интересный разговор(((\nИногда читаю книги, занимался спортом, пока не пошёл работать, разбираюсь в фильмах, общительный. Ищу собеседника, не важно кого (хотя желательно девушку (как то разговор с противоположным полом всегда интереснее идёт)) внимательный, умею слушать и не шучу над чужими траблами, ну в общем то и всё. Если что, в правом углу в опциях есть пункт автор поста, если заинтересовал, пишите!"
//            }
//          },
//          {
//            "type": "TAGS",
//            "data": {
//              "values": [
//                "thinking_out_loud"
//              ]
//            }
//          }
//        ],
//        "language": "en",
//        "awards": {
//          "recent": [],
//          "statistics": [],
//          "voices": 0,
//          "awardedByMe": false
//        },
//        "createdAt": 1600653689000,
//        "updatedAt": 1600664423000,
//        "page": null,
//        "author": {
//          "id": "394135",
//          "url": null,
//          "name": "Rayzo",
//          "banner": {
//            "type": "IMAGE",
//            "id": "e5/83/LzEaDYIekL8n5zaBHktvY.A0CgAKAAQAFAAVgCWAI.jpg",
//            "data": {
//              "extraSmall": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/e5/83/LzEaDYIekL8n5zaBHktvY_160x160.jpg",
//                "size": {
//                  "width": 160,
//                  "height": 160
//                }
//              },
//              "small": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/e5/83/LzEaDYIekL8n5zaBHktvY_320x320.jpg",
//                "size": {
//                  "width": 320,
//                  "height": 320
//                }
//              },
//              "original": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/e5/83/LzEaDYIekL8n5zaBHktvY_600x600.jpg",
//                "size": {
//                  "width": 600,
//                  "height": 600
//                }
//              }
//            }
//          },
//          "photo": {
//            "type": "IMAGE",
//            "id": "c8/59/CmhoeZKni9g5VKA2wmpSv.AUCIAKAA_wAsAQ.jpg",
//            "data": {
//              "extraSmall": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/c8/59/CmhoeZKni9g5VKA2wmpSv_136x160.jpg",
//                "size": {
//                  "width": 136,
//                  "height": 160
//                }
//              },
//              "original": {
//                "url": "https://d1wiosyzmyvfsz.cloudfront.net/c8/59/CmhoeZKni9g5VKA2wmpSv_255x300.jpg",
//                "size": {
//                  "width": 255,
//                  "height": 300
//                }
//              }
//            }
//          },
//          "gender": "MALE",
//          "isHidden": false,
//          "isBlocked": false,
//          "isMessagingAllowed": true,
//          "auth": {
//            "rocketId": "4fop66NoqqudAJNrp",
//            "isDisabled": false,
//            "level": 0
//          },
//          "statistics": {
//            "likes": 0,
//            "thanks": 1,
//            "uniqueName": false,
//            "thanksNextLevel": 500
//          },
//          "tagline": "",
//          "data": {}
//        },
//        "stats": {
//          "likes": {
//            "count": 2,
//            "my": false
//          },
//          "views": {
//            "count": 11613,
//            "my": false
//          },
//          "comments": {
//            "count": 0,
//            "my": false
//          },
//          "shares": {
//            "count": 0,
//            "my": false
//          },
//          "replies": {
//            "count": 0,
//            "my": false
//          },
//          "timeLeftToSpace": {
//            "count": null,
//            "my": false
//          }
//        },
//        "isMyFavorite": false
//      }
