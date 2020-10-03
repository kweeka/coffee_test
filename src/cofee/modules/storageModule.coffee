angular.module 'mainApp'
  .factory 'storage', ->
    user: null
    groupsAll: [
      {
        name: 'USER'
        checked: false
      }
      {
        name: 'ADMIN'
        checked: false
      }
    ]
    setUser: (user) ->
      this.user = user
    getUser: ->
      this.user
    changeNameUser: (name) ->
      this.user.name = name
    historySearch: []
    setHistorySearch: (item) ->
      this.historySearch.push(item)
    getHistorySearch: ->
      this.historySearch
  .factory 'noticeStorage', ->
    notices: null
    setNotices: (notices) ->
      this.notices = notices
    getNotices: () ->
      this.notices


