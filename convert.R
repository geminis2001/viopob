library(aspace)
options(digits=6)
convertLLtoLCC<-function ()
{
  e2<-0.00669438
  e <- sqrt(e2)
  lat<-13.812702
  long<- -89.230641
  firstStdParallel<-13.316666666666666666666666666667
  secondStdParallel<-14.25
  latOfOrigin<-13.783333333333333333333333333333
  longOfOrigin<- -89.0
  falseEasting <- 500000
  falseNorthing <- 295809.184
  a<-6378137.0
  
  phi 	<- as_radians(lat)						# Latitude to convert
  phi1	<- as_radians(firstStdParallel)			# Latitude of 1st std parallel
  phi2	<- as_radians(secondStdParallel)		# Latitude of 2nd std parallel
  lamda	<- as_radians(long)						# Lonitude to convert
  phio	<- as_radians(latOfOrigin)				# Latitude of  Origin
  lamdao	<- as_radians(longOfOrigin)				# Longitude of  Origin
  
  m1 <- cos(phi1) / sqrt(( 1 - e2*sin(phi1)*sin(phi1)))
  m2 <- cos(phi2) / sqrt(( 1 - e2*sin(phi2)*sin(phi2)))
  t1 <- tan((pi/4)-(phi1/2)) / ( ( 1 - e*sin(phi1) ) / ( 1 + e*sin(phi1) ))^(e/2)
  t2 <- tan((pi/4)-(phi2/2)) / ( ( 1 - e*sin(phi2) ) / ( 1 + e*sin(phi2) ))^(e/2)
  to <- tan((pi/4)-(phio/2)) / ( ( 1 - e*sin(phio) ) / ( 1 + e*sin(phio) ))^(e/2)
  t  <- tan((pi/4)-(phi /2)) / ( ( 1 - e*sin(phi ) ) / ( 1 + e*sin(phi ) ))^(e/2)
  n	<- (log(m1)-log(m2)) / (log(t1)-log(t2))
  FF	<- m1/(n*t1^n)
  rf	<- a*FF*to^n
  r	<-a*FF*t^n
  theta <- n*(lamda - lamdao)
  
  lccEasting <- falseEasting + r*sin(theta)
  lccNorthing <- falseNorthing + rf - r*cos(theta)
  print(lccEasting)
  print(lccNorthing)
}

g<-function (X,Y)
{
  e2<-0.00669438
  e = sqrt(e2)
  lat<-13.7830944444
  long<- -89.9548
  firstStdParallel<-13.316666666666666666666666666667
  secondStdParallel<-14.25
  latOfOrigin<-13.783333333333333333333333333333
  longOfOrigin<- -89.0
  falseEasting <- 500000
  falseNorthing <- 295809.184
  a<-6378137.0
  lccEasting<-X
  lccNorthing<-Y 
  
  
  phi1	= as_radians(firstStdParallel)			# Latitude of 1st std parallel
  phi2	= as_radians(secondStdParallel)		# Latitude of 2nd std parallel
  phio	= as_radians(latOfOrigin)				# Latitude of  Origin
  lamdao	= as_radians(longOfOrigin)				# Longitude of  Origin
  E		= lccEasting
  N		= lccNorthing
  Ef		= falseEasting
  Nf		= falseNorthing
  
  m1 = cos(phi1) / sqrt(( 1 - e2*sin(phi1)*sin(phi1)))
  m2 = cos(phi2) / sqrt(( 1 - e2*sin(phi2)*sin(phi2)))
  t1 = tan((pi/4)-(phi1/2)) / ( ( 1 - e*sin(phi1) ) / ( 1 + e*sin(phi1) ))^(e/2)
  t2 = tan((pi/4)-(phi2/2)) / ( ( 1 - e*sin(phi2) ) / ( 1 + e*sin(phi2) ))^(e/2)
  to = tan((pi/4)-(phio/2)) / ( ( 1 - e*sin(phio) ) / ( 1 + e*sin(phio) ))^(e/2)
  n	= (log(m1)-log(m2)) / (log(t1)-log(t2))
  FF	= m1/(n*t1^n)
  rf	= a*FF*to^n
  r_	= sqrt( (E-Ef)^2 + (rf-(N-Nf))^2 )
  t_	= (r_/(a*FF))^(1/n)
  theta_ = atan((E-Ef)/(rf-(N-Nf)))
  
  lamda	= theta_/n + lamdao
  phi0	= (pi/2) - 2*atan(t_)
  phi1	= (pi/2) - 2*atan(t_*((1-e*sin(phi0))/(1+e*sin(phi0)))^(e/2))
  phi2	= (pi/2) - 2*atan(t_*((1-e*sin(phi1))/(1+e*sin(phi1)))^(e/2))
  phi	= (pi/2) - 2*atan(t_*((1-e*sin(phi2))/(1+e*sin(phi2)))^(e/2))
  
  lat 	= as.double(180.0)*as.double(phi)/pi
  long = 180.0*lamda/pi
  sprintf("Lat: %.6f  Lon: %.6f",lat,long)
  #sprintf("Lon: %.6f",long)
  
}