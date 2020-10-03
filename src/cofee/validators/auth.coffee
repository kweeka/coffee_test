angular.module 'mainApp'
  .factory('validationAuth', ->
    validationEmail: (email) ->
      emailErr = []
      if (not email)
        emailErr.push('no value entered')
        emailErr
      else if not email.match(/\w+@\w+\.\w+/g)
        emailErr.push('format does not match email address')
        emailErr
      emailErr
    validationPassword: (password, pastPassword = '') ->
      passwordErr = []
      if (not password)
        passwordErr.push('no value entered')
        passwordErr
      else if not password.match(/[A-Z]+/g)
        passwordErr.push('capital letter must be used')
        if not password.match(/\w{6,40}/g)
          passwordErr.push('enter a value between 6 and 40')
      else if not password.match(/\w{6,40}/g)
        passwordErr.push('enter a value between 6 and 40')
        if not password.match(/[A-Z]+/g)
          passwordErr.push('capital letter must be used')
      else if pastPassword
        if pastPassword != password
          passwordErr.push('the password should not be different')
      console.log(passwordErr)
      passwordErr
    validationName: (name, pastName = '') ->
      nameErr = []
      if (not name)
        nameErr.push('no value entered')
        nameErr
      else if pastName
        if pastName == name
          nameErr.push('the new name must be different from the past name')
        nameErr
      nameErr
)