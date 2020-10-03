angular.module 'mainApp'
  .factory 'userService', ['$http', 'storage', ($http, storage) ->
    registration: (email, name, password) ->
      $http
        method: "POST"
        url: 'https://crawler.agafonov.me/api/user/register'
        data:
          email: email
          name: name
          password: password
    getUserInfo: () ->
      $http
        method: "GET"
        url: 'https://crawler.agafonov.me/api/user/get'
        headers:
          'Authorization': 'Bearer ' + localStorage.getItem("authToken")
    changeUser: (user) ->
      $http
        method: "POST"
        url: 'https://crawler.agafonov.me/api/user/update'
        data: user
        headers:
          'Authorization': 'Bearer ' + localStorage.getItem("authToken")
    getAutocomplete: (keywords, lang, deep) ->
      $http
        method: "POST"
        url: 'https://crawler.agafonov.me/api/google/google_autocomplete'
        data:
          keywords: keywords
          lang: lang
          deep: deep
        headers:
          'Authorization': 'Bearer ' + localStorage.getItem("authToken")
    getHistorySearch: () ->
      promise = new Promise((resolve, reject) ->
        resolve(storage.getHistorySearch())
        reject('err')
      )
    setHistorySearch: (item) ->
      promise = new Promise((resolve, reject) ->
        resolve(item)
        reject('err')
      )
  ]
  .factory 'noticeService', ['$http', 'storage', ($http, storage) ->
    getNotice: () ->
      if localStorage.getItem('notices')
        notices = JSON.parse(localStorage.getItem('notices'))
      else
        notices = [
          {
            id: 1
            topic: "Today 01/10/20"
            text: "The weather today is sunny"
            date: new Date()
            from: "Me"
            read: true
          }
          {
            id: 2
            topic: "Today 01/10/20"
            text: "The weather today is sunny"
            date: new Date()
            from: "Me"
            read: false
          }
        ]

      random = Math.random()
      if random > 0.5
        notices.push(new Notice(notices.length + 1, "Today 02/10/20", "The weather today is sunny", new Date(), "Me", false))

      promise = new Promise((resolve, reject) ->
        resolve(notices)
        reject('err')
      )
    changeNotice: (item) ->
      result = false
      if localStorage.getItem('notices')
        notices = JSON.parse(localStorage.getItem('notices'))
        for notice in notices
          if item == notice.id
            notice.read = true
        console.log(notices)
        localStorage.setItem('notices', JSON.stringify(notices))
        console.log(localStorage.getItem('notices'))
        result = true
      promise = new Promise((resolve, reject) ->
        resolve(result)
        reject(result)
      )
  ]