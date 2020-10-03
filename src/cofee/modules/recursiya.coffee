angular.module 'mainApp'
  .factory 'RecursionHelper', ['$compile', ($compile) ->
    {
      compile: (element, link) ->
        if angular.isFunction(link)
          link = { post: link }
        contents = element.contents().remove()
        compiledContents = ''
        {
          pre:
            if link && link.pre
              link.pre
            else
              null
          post: (scope, element) ->
            if !compiledContents
              compiledContents = $compile(contents)
            compiledContents(scope, (clone) ->
              element.append(clone);
            )
            if link && link.post
              link.post.apply(null, arguments)
        }

    }
  ]