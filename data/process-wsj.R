all_fcasts <- list.files("data/wsj-forecasts/")
fn = paste0("data/wsj-forecasts/", all_fcasts)
process <- function(x){
  dat = read_excel(x, n_max = 77, skip = 2, col_names = FALSE)
  dat = dat[,-1]
  header = c(unlist(read_excel(x, n_max = 1, skip = 1, col_names = FALSE)))
  series = c(unlist(read_excel(x, n_max = 1, skip = 0, col_names = FALSE)))
  series = c("","",series)
  if(length(header) < length(series)) {
    header = c(header, rep("", length(series) - length(header)))
  }
  header[is.na(header)] = ""
  series[is.na(series)] = ""
  for(i in 3:length(series)) if(series[i]=="") series[i] = series[i-1]
  names(dat) = paste0(series, " ", header)
  names(dat)[1:2] = c("name","org")
  dat %>% mutate(name = str_trim(gsub("\\*","",name)))
}

test = list()
for(i in 1:length(fn)) test[[i]] = process(fn[i])
names(test) = paste(month.abb, 2019)
all_econ = bind_rows(test, .id = "fcast month")

