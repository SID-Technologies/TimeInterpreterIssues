
library(httr)
library(jsonlite)
library(stringi)

.time_token <- "f6c02ccd45msh48a1aaec9639ec9p17d143jsn4df9ebbe2574"

time_from_string_api <- function(qry = NULL, api_key = NULL, tz = NULL, ...){
  
  if(is.null(api_key)){
    .msg <- c(
      "CANNOT PERFORM QUERY WITHOUT A KEY!",
      "PLEASE VISIT https://rapidapi.com/sid-technologies-llc-sid-technologies-llc-default/api/time-interpreter/ to obtain an API KEY"
    )
    stop(.msg)
  }
  
  .headers <- list(
    `X-RapidAPI-Key` = api_key,
    `X-RapidAPI-Host` = "time-interpreter.p.rapidapi.com"
  )
  
  url <- "https://time-interpreter.p.rapidapi.com/time"
  
  .qry <- list(
    message = stringi::stri_trim_both(qry),
    time_zone = tz
  )
  
  raw <- httr::POST(
    url = url, 
    body = jsonlite::toJSON(.qry[!mapply(is.null, .qry)], auto_unbox = TRUE),
    add_headers(unlist(.headers), ...)
  )
  
  httr::stop_for_status(
    raw, 
    task = c(
      rawToChar(raw$request$options$postfields), 
      sprintf("Issue in query. Request returned %s status code", httr::status_code(raw))
    )
  )
  
  httr::content(raw)
  
}
