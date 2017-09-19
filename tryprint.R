mainPrint =
  #
  # main function
  #
  function(client_id = client.id, user, password) {
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
    if (printDbname(client_id = client_id, user, password)) {
      dbname = printDbname(client_id = client_id, user, password)
    }
    else(return('wrong!'))
    # print result
    print(paste0('Running client is ', dbname,
                 '. The final result is %', fit.result$mape * 100, ' mape',
                 ', %', fit.result$rmse * 100, ' rmse',
                 ', %', fit.result$mae * 100, ' mae.'))
  }
  
password = Sys.getenv('DB.PASSWORD')
user = Sys.getenv('DB.USER')
client_id = Sys.getenv('CLIENTID')
mainPrint(client_id, user, password)
