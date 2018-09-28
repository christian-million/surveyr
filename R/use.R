use_detail <- function(x){
 
out <- use_gen(x, "detail")
return(out)

}

use_desc <- function(x){
 
out <- use_gen(x, "desc")
return(out)

}


use_group <- function(x){
 
out <- use_gen(x, "group")
return(out)

}


use_gen <- function(x, schema_var){
  
  name <- switch(schema_var, 
                 "detail" = "q_detail",
                 "desc" = "q_description",
                 "group" = "q_group")
  
  names(x) <- schema[[name]][match(names(x), schema$q_varname)]
  
  return(x)
}
