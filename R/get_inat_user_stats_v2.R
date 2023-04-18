#########################################
#########################################
## Modifying the get_inat_user_stats function to add more query choices

get_inat_user_stats_v2 <- function (date = NULL, date_range = NULL, place = NULL, project = NULL, month = NULL, 
                                    nelat = NULL, nelng = NULL, swlat = NULL, swlng = NULL, taxon_id = NULL,
                                    uid = NULL) 
{
  if (!curl::has_internet()) {
    message("No Internet connection.")
    return(invisible(NULL))
  }
  base_url <- "http://www.inaturalist.org/"
  if (httr::http_error(base_url)) {
    message("iNaturalist API is unavailable.")
    return(invisible(NULL))
  }
  q_path <- "observations/user_stats.json"
  search <- ""
  if (!is.null(date)) {
    search <- paste0(search, "&on=", date)
  }
  if (!is.null(date_range)) {
    search <- paste0(search, "d1=", date_range[1], "&d2=", 
                     date_range[2])
  }
  
  if (!is.null(project)) {
    search <- paste0(search, "projects=", project)
  }
  if (!is.null(uid)) {
    search <- paste0(search, "&user_id=", uid)
  }
  if (!is.null(month)) {
    search <- paste0(search, "&month=", month)
  }
  if (!is.null(nelat)) {
    search <- paste0(search, "&nelat=", nelat)
  }
  if (!is.null(nelng)) {
    search <- paste0(search, "&nelng=", nelng)
  }
  if (!is.null(place)) {
    search <- paste0(search, "&place_id=", place)
  }
  if (!is.null(swlat)) {
    search <- paste0(search, "&swlat=", swlat)
  }
  if (!is.null(swlng)) {
    search <- paste0(search, "&swlng=", swlng)
  }
  if (!is.null(taxon_id)) {
    search <- paste0(search, "&taxon_id=", taxon_id)
  }
  
  data <- fromJSON(httr::content(httr::GET(base_url, path = q_path, query = search), 
                                 as = "text"))
  return(data)
}
