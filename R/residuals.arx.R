residuals.arx <-
function(object, std=FALSE, ...)
{
  ##determine spec:
  if(is.null(std)){
    std <- switch(as.character(object$call)[1],
      arx=FALSE, getsm=FALSE, getsv=TRUE)
  }

  if(std){
    result <- object$std.residuals
  }else{
    result <- object$residuals
  }
  return(result)
}
