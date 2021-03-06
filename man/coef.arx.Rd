\name{coef.arx}
\alias{coef.arx}
\alias{fitted.arx}
\alias{logLik.arx}
\alias{plot.arx}
\alias{predict.arx}
\alias{print.arx}
\alias{residuals.arx}
\alias{sigma.arx}
\alias{summary.arx}
\alias{vcov.arx}

\title{Extraction functions for 'arx' objects}

\description{Extraction functions for objects of class 'arx'}

\usage{
  \method{coef}{arx}(object, spec=NULL, ...)
  \method{fitted}{arx}(object, spec=NULL, ...)
  \method{logLik}{arx}(object, ...)
  \method{plot}{arx}(x, spec=NULL, col=c("red","blue"),
    lty=c("solid","solid"), lwd=c(1,1), ...)
  \method{predict}{arx}(object, spec=NULL, n.ahead=12, newmxreg=NULL,
    newvxreg=NULL, newindex=NULL, n.sim=1000, innov=NULL, return=TRUE,
    plot=NULL, plot.options=list(), ...)
  \method{print}{arx}(x, signif.stars=FALSE, ...)
  \method{residuals}{arx}(object, std=FALSE, ...)
  \method{sigma}{arx}(object, ...)
  \method{summary}{arx}(object, ...)
  \method{vcov}{arx}(object, spec=NULL, ...)
}

\arguments{
  \item{object}{an object of class 'arx'}
  \item{x}{an object of class 'arx'}
  \item{spec}{NULL, "mean", "variance" or, in some instances, "both". When \code{NULL} is a valid value, then it is automatically determined whether information pertaining to the mean or variance specification should be returned}
  \item{signif.stars}{logical. If \code{TRUE}, then P-values are additionally encoded visually, see \code{printCoefmat} }
  \item{std}{logical. If FALSE (default), then the mean residuals are returned. If TRUE, then the standardised residuals are returned}
  \item{n.ahead}{generate forecasts up to n steps ahead (the default is 12)}
  \item{newmxreg}{a matrix (\code{n.ahead} rows and \code{NCOL(mxregs)} columns) with the out-of-sample values of the \code{mxreg} regressors}
  \item{newvxreg}{a matrix (\code{n.ahead} rows and \code{NCOL(vxregs)} columns) with the out-of-sample values of the \code{vxreg} regressors}
  \item{newindex}{date-index for the \code{zoo} object returned by \code{predict.arx}}
  \item{n.sim}{integer, the number of bootstrap replications for the generation of the variance forecasts}
  \item{innov}{\code{NULL} (default) or a vector of length \code{n.ahead * n.sim} containing the standardised errors (i.e. zero mean, unit variance) to bootstrap from}
  \item{return}{logical. If \code{TRUE} (default), then the out-of-sample forecasts are returned}
  \item{plot}{NULL or logical. If \code{TRUE} (default), then the out-of-sample forecasts are plotted. If NULL (default), then the value set by \code{\link{options}} determines whether a plot is produced or not.}
  \item{plot.options}{a \code{list} of options related to the plotting of forecasts, see 'Details'}
  \item{col}{colours of actual (default=blue) and fitted (default=red) lines}
  \item{lty}{types of actual (default=solid) and fitted (default=solid) lines}
  \item{lwd}{widths of actual (default=1) and fitted (default=1) lines}
  \item{\dots}{additional arguments}
}

\value{
  \item{coef:}{a numeric vector containing parameter estimates}
  \item{fitted:}{a \code{\link{zoo}} object with fitted values}
  \item{logLik:}{log-likelihood (normal density)}
  \item{plot:}{a plot of the fitted values and the residuals}
  \item{predict}{a vector containing the out-of-sample forecasts}
  \item{print:}{a print of the estimation results}
  \item{residuals:}{a \code{\link{zoo}} object with the residuals}
  \item{sigma:}{the regression standard error ('SE of regression')}
  \item{summary:}{a print of the items in the \code{\link{arx}} object}
  \item{vcov:}{variance-covariance matrix}
}

\details{
The \code{plot.options} argument is a list that can contain any of the following arguments:\cr

\code{keep}: integer greater than zero (default is 10) that controls the number of in-sample actual values to plot\cr
\code{fitted}: If \code{TRUE}, then the fitted values as well as actual values are plotted in-sample. The default is \code{FALSE}\cr
\code{errors.only}: logical or \code{NULL} (the default). If \code{TRUE}, then only mean forecasts are plotted when \code{spec} is set to "both"\cr
\code{legend.loc}: character string (the default is "topleft"). Allows the location of the plot legend to be altered\cr
\code{newmactual}: numeric vector or \code{NULL} (default). Enables the plotting of actual values out-of-sample in addition to the forecasts\cr

}

\author{
Felix Pretis, \url{http://www.felixpretis.org/}\cr
James Reade, \url{https://sites.google.com/site/jjamesreade/}\cr
Genaro Sucarrat, \url{http://www.sucarrat.net/}
}

\seealso{\code{\link{arx}}}

\examples{
##simulate from an AR(1):
set.seed(123)
y <- arima.sim(list(ar=0.4), 40)

##simulate four independent Gaussian regressors:
xregs <- matrix(rnorm(4*40), 40, 4)

##estimate an AR(2) with intercept and four conditioning
##regressors in the mean, and log-ARCH(3) in the variance:
mymod <- arx(y, mc=TRUE, ar=1:2, mxreg=xregs, arch=1:3)

##print results:
print(mymod)

##plot the fitted vs. actual values, and the residuals:
plot(mymod)

##generate out-of-sample forecasts of the mean:
predict(mymod, newmxreg=matrix(0,12,4))

##print the entries of object 'mymod':
summary(mymod)

##extract coefficient estimates (automatically determined):
coef(mymod)

##extract mean coefficients only:
coef(mymod, spec="mean")

##extract log-variance coefficients only:
coef(mymod, spec="variance")

##extract all coefficient estimates:
coef(mymod, spec="both")

##extract regression standard error:
sigma(mymod)

##extract log-likelihood:
logLik(mymod)

##extract variance-covariance matrix of mean equation:
vcov(mymod)

##extract variance-covariance matrix of log-variance equation:
vcov(mymod, spec="variance")

##extract and plot the fitted mean values (automatically determined):
mfit <- fitted(mymod)
plot(mfit)

##extract and plot the fitted variance values:
vfit <- fitted(mymod, spec="variance")
plot(vfit)

##extract and plot both the fitted mean and variance values:
vfit <- fitted(mymod, spec="both")
plot(vfit)

##extract and plot the fitted mean values:
vfit <- fitted(mymod, spec="mean")
plot(vfit)

##extract and plot residuals:
epshat <- residuals(mymod)
plot(epshat)

##extract and plot standardised residuals:
zhat <- residuals(mymod, std=TRUE)
plot(zhat)

}

\keyword{Statistical Models}
\keyword{Time Series}
\keyword{Econometrics}
\keyword{Financial Econometrics}
