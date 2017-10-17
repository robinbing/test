mainPrint =
  #
  # main function
  #
  function(client_id = client.id, user, password) {
    library(FeatureSelection)
    # check package
    if(!require(toy)) {
      library(devtools)
      install.packages("toy")
    }

    # fit result
    real = 1:3
    predict = real + rnorm(3, 0, 0.1)
    fit.result = fitStats(real, predict)

    # print Client dbname
    tryCatch({dbname = printDbname(client_id = client_id, user, password)},
             error = function(e) NULL)
    if(exists('dbname')){
      print(paste0('Running client is ', dbname,
                   '. The final result is %', fit.result$mape * 100, ' mape',
                   ', %', fit.result$rmse * 100, ' rmse',
                   ', %', fit.result$mae * 100, ' mae.'))
    } else {
      return('Cannot access MySQL db. Check internet settings.')
    }
  }
  
password = Sys.getenv('DB.PASSWORD')
user = Sys.getenv('DB.USER')
client_id = Sys.getenv('CLIENTID')
mainPrint(client_id, user, password)
