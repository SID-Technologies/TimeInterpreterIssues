# Time Interpreter Issues

This is the support repo for the Time Interpreter API. Please create an issue is there is any error in a given `messsage` returning an inaccurate response or if you find another human readable text that might not be suported. 


# Examples  
Using the included **[R wrapper function](/wrapper/time_from_string.R)** function.  

__You will need an api key, which can be obtained by signing up at [rapidAPI](https://rapidapi.com/sid-technologies-llc-sid-technologies-llc-default/api/time-interpreter)__  


Showing the current time for reference:  

```r
> Sys.time()
[1] "2023-03-13 10:15:04 CDT"
```

```r
# Assuming you're in this working directory

> source("wrapper/time_from_string.R")

> .time_token <- "<The Token you obtain when you sign up at rapidapi.com>"

> r <- time_from_string_api(qry = "Last Thursday", api_key = .time_token, tz = stringi::stri_timezone_get())

> str(r)
List of 5
 $ time_zone     : chr "America/Chicago"
 $ date_time     : chr "2023-03-09T00:00:00"
 $ start_time    : chr "2023-03-09T00:00:00"
 $ end_time      : chr "2023-03-09T23:59:59"
 $ message_grains:List of 1
  ..$ : chr "DAY"
```

To see that the output was what we were hoping for:  

```r
Map(strftime, r[grep("time$", names(r))], format = "%A") 

```

```
List of 3
 $ date_time : chr "Thursday"
 $ start_time: chr "Thursday"
 $ end_time  : chr "Thursday"
```
