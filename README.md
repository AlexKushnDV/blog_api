# Ruby on Rails Blog API

***
```

git clone https://github.com/AlexKushnDV/blog_api.git
cd blog_api
Установить или проверить установленные версии Ruby и Ruby on Rails
(
ruby 3.0.0p0 
Rails 6.1.4.1
)
нужна установленная SQlite 3
далее
bundle install
rails db:migrate RAILS_ENV=development
rails db:seed RAILS_ENV=development
rails s
```
***
## Вход/регистрация

### Регистрация
***
### Requests 
```
POST /api/v1/users HTTP/1.1
Host: localhost:3000

# Header
Content-Type: application/json
Content-Length: 93

# Body
{
    "user": {
        "email": "test101010@email.com",
        "password": "123456"
        }
}
```
### Response 
Status: 201 Created
```
{
    "data": {
        "id": "9",
        "type": "user",
        "attributes": {
            "email": "test101010@email.com"
        }
    }
}
```
Пароль меньше 6 символов

Status: 422 Unprocessable Entity
```
{
    "password": [
        "is too short (minimum is 6 characters)"
    ]
}
```
Некорректный email

Status: 422 Unprocessable Entity
```
{
    "email": [
        "is invalid"
    ]
}
```
Не уникальный email

Status: 422 Unprocessable Entity
```
{
    "email": [
        "has already been taken"
    ]
}
```
***
### Вход осуществляется по email + password.
***
### Requests
```
POST /api/v1/login HTTP/1.1
Host: localhost:3000

# Header
Content-Type: application/json
Content-Length: 104

# Body
{
    "user": {
        "email": "blanca_denesik@mertz-fadel.name",
        "password": "123456"
    }
}
```
### Response 
Status: 200 OK
```
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MzEwODM4NDl9.WqAnrTqV_GDtC0lar4De9om-lmBkkWRjPt3qrN3qrz4",
    "email": "blanca_denesik@mertz-fadel.name"
}
```
При неправильных данных запроса( email, password)
```
Status: 401 Unauthorized

```


## Статья

### Создание статьи
***
### Requests
```
POST /api/v1/articles HTTP/1.1
Host: localhost:3000

Header
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MzEwMzIyNjN9.Hk6xwO_xTRbODaVj-2WOGdMCyyhZ-iTbcc-86-2h7K4
Content-Type: application/json
Content-Length: 634

Body
{

  "article": {
    "title": "The Green Bay Tree YYYYYYYYYYYYYY",
    "content": "Далеко-далеко за словесными горами в стране гласных и согласных живут рыбные тексты. 
    Вдали от всех живут они в буквенных домах на берегу Семантика большого языкового океана. 
    Маленький ручеек Даль журчит по всей стране и обеспечивает ее всеми необходимыми правилами. Э
    та парадигматическая страна, в которой жаренные члены предложения залетают прямо в рот. 
    Даже всемогущая пунктуация не имеет власти над рыбными текстами, ведущими безорфографичный 
    образ жизни. Однажды одна маленькая строчка рыбного текста по им",
    "category": "Mystery",
    "date": "2021-09-05"
  }
}
```

### Response
Status: 201 Created
```
{
    "data": {
        "id": "20",
        "type": "article",
        "attributes": {
            "title": "The Green Bay Tree YYYYYYYYYYYYYY",
            "content": "Далеко-далеко за словесными горами в стране гласных и согласных живут рыбные тексты.
             Вдали от всех живут они в буквенных домах на берегу Семантика большого языкового океана. 
             Маленький ручеек Даль журчит по всей стране и обеспечивает ее всеми необходимыми правилами. 
             Эта парадигматическая страна, в которой жаренные члены предложения залетают прямо в рот. 
             Даже всемогущая пунктуация не имеет власти над рыбными текстами, ведущими безорфографичный 
             образ жизни. Однажды одна маленькая строчка рыбного текста по им",
            "category": "Mystery",
            "date": "2021-09-05"
        },
        "relationships": {
            "author": {
                "data": {
                    "id": "1",
                    "type": "user"
                }
            },
            "comments": {
                "data": []
            }
        },
        "meta": {
            "comments_count": 0
        }
    }
}
```
### Оставить комментарий под статьей
***
### Requests

```
POST /api/v1/articles/20/comments HTTP/1.1
Host: localhost:3000

# Header
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2LCJleHAiOjE2MzEwODUxNjN9.z-CQVQLVd7xRINuowCv6nD2Tz-VCJa-dXYRuM1lL9UI
Content-Type: application/json
Content-Length: 94

# Body
{
  "comment": {
   "content": "Dignissimos excepturi asperiores. Dolore quae officiis."
  }
}
```
### Response
Status: 201 Created
```
{
    "data": {
        "id": "38",
        "type": "comment",
        "attributes": {
            "content": "Dignissimos excepturi asperiores. Dolore quae officiis."
        },
        "relationships": {
            "article": {
                "data": {
                    "id": "20",
                    "type": "article"
                }
            },
            "user": {
                "data": {
                    "id": "6",
                    "type": "user"
                }
            }
        }
    }
}
```
##**Далее кратко запрос - ответ**
### Получить конкретную статью
***
### Requests
```
GET /api/v1/articles/20 HTTP/1.1
Host: localhost:3000
```
### Response
Status: 200 OK
```
{
    "data": {
        "id": "20",
        "type": "article",
        "attributes": {
            "title": "The Green Bay Tree YYYYYYYYYYYYYY",
            "content": "Далеко-далеко за словесными горами в стране гласных и согласных живут рыбные тексты. 
            Вдали от всех живут они в буквенных домах на берегу Семантика большого языкового океана. 
            Маленький ручеек Даль журчит по всей стране и обеспечивает ее всеми необходимыми правилами. 
            Эта парадигматическая страна, в которой жаренные члены предложения залетают прямо в рот. 
            Даже всемогущая пунктуация не имеет власти над рыбными текстами, ведущими безорфографичный 
            образ жизни. Однажды одна маленькая строчка рыбного текста по им",
            "category": "Mystery",
            "date": "2021-09-05"
        },
        "relationships": {
            "author": {
                "data": {
                    "id": "1",
                    "type": "user"
                }
            },
            "comments": {
                "data": [
                    {
                        "id": "38",
                        "type": "comment"
                    }
                ]
            }
        },
        "meta": {
            "comments_count": 1
        }
    },
    "included": [
        {
            "id": "1",
            "type": "user",
            "attributes": {
                "email": "blanca_denesik@mertz-fadel.name"
            }
        }
    ]
}
```
### Получить комментарии определенной статьи
***
### Requests
```
GET /api/v1/articles/20/comments HTTP/1.1
Host: localhost:3000
```
### Response
Status: 200 OK
```
{
    "data": [
        {
            "id": "38",
            "type": "comment",
            "attributes": {
                "content": "Dignissimos excepturi asperiores. Dolore quae officiis."
            },
            "relationships": {
                "article": {
                    "data": {
                        "id": "20",
                        "type": "article"
                    }
                },
                "user": {
                    "data": {
                        "id": "6",
                        "type": "user"
                    }
                }
            }
        }
    ],
    "included": [
        {
            "id": "6",
            "type": "user",
            "attributes": {
                "email": "test@email.com"
            }
        }
    ]
}

```
### Поиск статей по автору
***
### Requests
```
GET /api/v1/articles?email=brook@jakubowski.com HTTP/1.1
Host: localhost:3000
```
### Response
Status: 200 OK
```
{
    "data": [
        {
            "id": "14",
            "type": "article",
            "attributes": {
                "title": "A Catskill Eagle",
                "content": "Reprehenderit qui voluptatibus. Minus consequuntur laudantium. Rerum ipsam dolor.
                 Consectetur quia rerum. Magnam iusto ut. Sit est nesciunt. Earum illum commodi. Omnis tenetur sit. 
                 Sed vero sint. Iure ut nemo. Impedit est atque. Delectus corporis reiciendis. Alias non corporis. 
                 Voluptates accusantium soluta. Velit modi corrupti. Molestiae eos nisi. Et adipisci et. Accusantium
                  odio culpa. Rerum consequatur impedit. Rem doloribus impedit. Expedita dolores vel. Explicabo 
                  adipisci eos. Voluptatem as...",
                "category": "Western",
                "date": "2021-09-05"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "5",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": [
                        {
                            "id": "27",
                            "type": "comment"
                        },
                        {
                            "id": "28",
                            "type": "comment"
                        }
                    ]
                }
            },
            "meta": {
                "comments_count": 2
            }
        },
        {
            "id": "15",
            "type": "article",
            "attributes": {
                "title": "A Scanner Darkly",
                "content": "Accusamus itaque eos. Voluptatem eum repellat. Suscipit delectus quia. Ipsa soluta ea.
                 Sit sunt id. Vero aut aut. Quod neque quidem. Earum consequatur itaque. In deserunt consequuntur.
                  Consequuntur cupiditate perspiciatis. Voluptas repudiandae facere. Est omnis nihil. Et temporibus 
                  qui. Odit ex eveniet. Ut eveniet quis. Et aliquam architecto. Dolores vero rerum. Asperiores voluptas 
                  maxime. Voluptas id ut. Illo autem ea. Et sit omnis. Nihil magnam sequi. Similique ut nihil. 
                  Dolores praesentium hi...",
                "category": "Western",
                "date": "2021-09-04"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "5",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": [
                        {
                            "id": "29",
                            "type": "comment"
                        },
                        {
                            "id": "30",
                            "type": "comment"
                        }
                    ]
                }
            },
            "meta": {
                "comments_count": 2
            }
        },
        {
            "id": "13",
            "type": "article",
            "attributes": {
                "title": "Clouds of Witness",
                "content": "Aliquid doloribus est. Minima nam sint. 
                Tempora accusamus qui. Voluptatem alias aut. Dolorem dolorum qui. 
                Omnis omnis rem. Delectus in assumenda. Blanditiis est autem. 
                Adipisci maxime molestiae. Excepturi omnis est. Praesentium sequi
                 neque. Amet dolorem illo. Nulla qui beatae. Rem eum delectus. 
                 Reprehenderit quia cum. Hic et quam. Sed commodi quis. 
                 Nulla unde quaerat. Est quia sed. Ut aut laboriosam. 
                 Facere voluptate non. Nam accusantium laboriosam. Ab consequuntur 
                 qui. Itaque facilis dolorem. D...",
                "category": "Western",
                "date": "2021-09-02"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "5",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": [
                        {
                            "id": "25",
                            "type": "comment"
                        },
                        {
                            "id": "26",
                            "type": "comment"
                        }
                    ]
                }
            },
            "meta": {
                "comments_count": 2
            }
        }
    ]
}
```
### Поиск статей по категории
***
### Requests
```
GET /api/v1/articles?category=Mystery HTTP/1.1
Host: localhost:3000
```
### Response
Status: 200 OK
```
{
    "data": [
        {
            "id": "16",
            "type": "article",
            "attributes": {
                "title": "The Green Bay Tree YYYYYYYYYYYYYY",
                "content": "Dignissimos excepturi asperiores. 
                Dolore quae officiis. Deserunt ut aut. Est et doloribus. 
                Quis et voluptas. Maxime et quidem. Impedit sit totam. 
                Minus officia et. Doloribus unde nihil. Omnis accusamus 
                voluptas. Consectetur aut enim. Aspernatur corporis autem. 
                Assumenda nam in. Sapiente asperiores delectus. Qui fugit 
                libero. Blanditiis est iste. Voluptatibus molestiae inventore
                . Suscipit perferendis voluptatem. Aut est sunt. 
                Quisquam architecto voluptas. Animi odit dolores. 
                Quia et sunt. Fuga do...",
                "category": "Mystery",
                "date": "2021-09-05"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "1",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": [
                        {
                            "id": "37",
                            "type": "comment"
                        }
                    ]
                }
            },
            "meta": {
                "comments_count": 1
            }
        },
        {
            "id": "17",
            "type": "article",
            "attributes": {
                "title": "The Green Bay Tree YYYYYYYYYYYYYY",
                "content": "Далеко-далеко за словесным
                и горами в стране гласных и согласных живут рыбные тексты. 
                Вдали от всех живут они в буквенных домах на берегу Семантика 
                большого языкового океана. Маленький ручеек Даль журчит по всей 
                стране и обеспечивает ее всеми необходимыми правилами. 
                Эта парадигматическая страна, в которой жаренные члены предложения 
                залетают прямо в рот. Даже всемогущая пунктуация не имеет власти
                 над рыбными текстами, ведущими безорфографичный образ жизни. 
                 Однажды одна маленькая строчка рыбного те...",
                "category": "Mystery",
                "date": "2021-09-05"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "1",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": []
                }
            },
            "meta": {
                "comments_count": 0
            }
        },
        {
            "id": "18",
            "type": "article",
            "attributes": {
                "title": "The Green Bay Tree YYYYYYYYYYYYYY",
                "content": "Далеко-далеко за словесными горами в стране 
                гласных и согласных живут рыбные тексты. Вдали от всех
                 живут они в буквенных домах на берегу Семантика большого 
                 языкового океана. Маленький ручеек Даль журчит по всей стране 
                 и обеспечивает ее всеми необходимыми правилами. 
                 Эта парадигматическая страна, в которой жаренные члены 
                 предложения залетают прямо в рот. Даже всемогущая пунктуация 
                 не имеет власти над рыбными текстами, ведущими безорфографичный 
                 образ жизни. Однажды одна маленькая строчка рыбного те...",
                "category": "Mystery",
                "date": "2021-09-05"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "1",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": []
                }
            },
            "meta": {
                "comments_count": 0
            }
        },  
        ... 
        ...
}
```

### Получение всех статей
***
### Requests
```
GET /api/v1/articles HTTP/1.1
Host: localhost:3000
```
### Response
Status: 200 OK
```
{
    "data": [
        {
            "id": "14",
            "type": "article",
            "attributes": {
                "title": "A Catskill Eagle",
                "content": "Reprehenderit qui voluptatibus. Minus consequuntur laudantium. Rerum ipsam dolor. Consectetur quia rerum. Magnam iusto ut. Sit est nesciunt. Earum illum commodi. Omnis tenetur sit. Sed vero sint. Iure ut nemo. Impedit est atque. Delectus corporis reiciendis. Alias non corporis. Voluptates accusantium soluta. Velit modi corrupti. Molestiae eos nisi. Et adipisci et. Accusantium odio culpa. Rerum consequatur impedit. Rem doloribus impedit. Expedita dolores vel. Explicabo adipisci eos. Voluptatem as...",
                "category": "Western",
                "date": "2021-09-05"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "5",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": [
                        {
                            "id": "27",
                            "type": "comment"
                        },
                        {
                            "id": "28",
                            "type": "comment"
                        }
                    ]
                }
            },
            "meta": {
                "comments_count": 2
            }
        },
        {
            "id": "16",
            "type": "article",
            "attributes": {
                "title": "The Green Bay Tree YYYYYYYYYYYYYY",
                "content": "Dignissimos excepturi asperiores. Dolore quae officiis. Deserunt ut aut. Est et doloribus. Quis et voluptas. Maxime et quidem. Impedit sit totam. Minus officia et. Doloribus unde nihil. Omnis accusamus voluptas. Consectetur aut enim. Aspernatur corporis autem. Assumenda nam in. Sapiente asperiores delectus. Qui fugit libero. Blanditiis est iste. Voluptatibus molestiae inventore. Suscipit perferendis voluptatem. Aut est sunt. Quisquam architecto voluptas. Animi odit dolores. Quia et sunt. Fuga do...",
                "category": "Mystery",
                "date": "2021-09-05"
            },
            "relationships": {
                "author": {
                    "data": {
                        "id": "1",
                        "type": "user"
                    }
                },
                "comments": {
                    "data": [
                        {
                            "id": "37",
                            "type": "comment"
                        }
                    ]
                }
            },
            "meta": {
                "comments_count": 1
            }
        },
        ...,
        ...,
      
    ]
}
```
### Удаление статьи
***
### Requests
```
DELETE /api/v1/articles/2 HTTP/1.1
Host: localhost:3000
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MzEwOTA1MDB9.Y7y15YKmSMu4XyU1Um5dKatAvrmpQeKMYpsKlG4pg_s
```
### Response
Status: 204 No content
```

```

### Удаление комментария к статье
***
### Requests
```
DELETE /api/v1/articles/3/comments/6 HTTP/1.1
Host: localhost:3000
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MzEwOTA1MDB9.Y7y15YKmSMu4XyU1Um5dKatAvrmpQeKMYpsKlG4pg_s
```
### Response
Status: 204 No content
```

```