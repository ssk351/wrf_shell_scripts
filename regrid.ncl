;###############
; test
;;;;;;;;;;;e
;;;;$$$$  ; functions ;;;

;;;# isodd             ; checks the whether the given num is odd
;;;# iseven            ; checks the whether the given num is even
;;;# remapTLL             ; regridding with linear intepolation 
;;;# maskingTLL           ; masking with ref data
;;;# remap_maskingTLL     ;both remap and masking 
;;;# remapLL          ; regridding along lat and lon
;;;# maksingLL        ; masking along lat and lon
;;;# acctodaily       ; accumulated rainfall into daily rainfall
;;;# todaily          ; converts 3hly to daily
;;;# bias             ; bias of the given variables
;;;# Percentile       ; percentile quartile
;;;# hhtodaily        ; HHly to Dly
;;;;$$$$   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;
; function isodd
; Doc self Discriptive.
; argument should be integer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef("isodd")
function isodd(number:integer)
begin
  if ( number %2 .ne. 0) then
    return(True)
  else
    return(False)
  end if
end
;;=======================================================

;;;;;;;;;;;;;;;;;;;;;;
; Function iseven
;argument should be integer
;;;;;;;;;;;;;;;;;;;;;
undef("iseven")
function iseven(number:integer)
begin
  return(.not.isodd(number))
  end
;;=======================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function remapTLL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
undef("remapTLL")
function remapTLL(x[*][*][*]:numeric,y[*][*][*]:numeric)
local dims,ntime,nlat,nlon,dim_Names,newtime,newlat,newlon,dim_Names1,ui,uj,xo
begin
;;;;variable to;;;;;;;
  dims = dimsizes(x)
  ntime= dims(0)
  nlat = dims(1)
  nlon = dims(2)
  dim_Names=getvardims(x)
  newtime = ispan(0,ntime-1,1)
  newlat=fspan(min(x&$dim_Names(1)$),max(x&$dim_Names(1)$),nlat)
  newlon=fspan(min(x&$dim_Names(2)$),max(x&$dim_Names(2)$),nlon)
;;;;;Variable from;;;;;;;
  dim_Names1=getvardims(y)
  ui=y&$dim_Names1(1)$  ;;lat
  uj=y&$dim_Names1(2)$  ;;lon
  xo=linint2(uj,ui,y,True,newlon,newlat,-999)
  copy_VarAtts(x,xo)
  copy_VarCoords(x,xo)
  return(xo)
end

;;;;;;;;;;;;;;;;;;;;
;;Function maskingTLL
;;;;;;;;;;;;;;;;;;;;
undef("maskingTLL")
function maskingTLL(x[*][*][*]:numeric,y[*][*][*]:numeric)
local yo
begin
  print(";;;;;;; note : dimensions should be same size")
  yo=where(.not.ismissing(x),y,x@_FillValue)
  copy_VarAtts(x,yo)
  copy_VarCoords(x,yo)
  return(yo)
end
;;;;;;;;;;;;;;;;;
;;Function remap_masking
;;;;;;;;;;;;;;;;
undef("remap_maskingLL")
function remap_maskingLL(x[*][*]:numeric,y[*][*]:numeric)
local dims,ntime,nlat,nlon,dim_Names,newtime,newlat,newlon,dim_Names1,ui,uj,xo,yo
begin
;;;;variable to;;;;;;;
  dims = dimsizes(x)
  nlat = dims(0)
  nlon = dims(1)
  dim_Names=getvardims(x)

  newlat=fspan(min(x&$dim_Names(0)$),max(x&$dim_Names(0)$),nlat)
  newlon=fspan(min(x&$dim_Names(1)$),max(x&$dim_Names(1)$),nlon)
;;;;;Variable from;;;;;;;
  dim_Names1=getvardims(y)
  ui=y&$dim_Names1(0)$  ;;lat
  uj=y&$dim_Names1(1)$  ;;lon
  xo=linint2(uj,ui,y,True,newlon,newlat,-999)
  copy_VarAtts(x,xo)
  copy_VarCoords(x,xo)
  yo=where(.not.ismissing(x),xo,x@_FillValue)
 copy_VarAtts(x,yo)
  copy_VarCoords(x,yo)
  return(yo)
end

;;;;;;;;;;;;;;;;;
;;Function remap_masking
;;;;;;;;;;;;;;;;
undef("remap_maskingTLL")
function remap_maskingTLL(x[*][*][*]:numeric,y[*][*][*]:numeric)
local dims,ntime,nlat,nlon,dim_Names,newtime,newlat,newlon,dim_Names1,ui,uj,xo,yo
begin
;;;;variable to;;;;;;;
  dims = dimsizes(x)
  ntime= dims(0)
  nlat = dims(1)
  nlon = dims(2)
  dim_Names=getvardims(x)
  newtime = ispan(0,ntime-1,1)
  newlat=fspan(min(x&$dim_Names(1)$),max(x&$dim_Names(1)$),nlat)
  newlon=fspan(min(x&$dim_Names(2)$),max(x&$dim_Names(2)$),nlon)
;;;;;Variable from;;;;;;;
  dim_Names1=getvardims(y)
  ui=y&$dim_Names1(1)$  ;;lat
  uj=y&$dim_Names1(2)$  ;;lon
  xo=linint2(uj,ui,y,True,newlon,newlat,-999)
  copy_VarAtts(x,xo)
  copy_VarCoords(x,xo)
  yo=where(.not.ismissing(x),xo,x@_FillValue)
 copy_VarAtts(x,yo)
  copy_VarCoords(x,yo)
  return(yo)
end

;;;;;;;;;;;;;;;;;;;;;;
;;remapLL
;;;;;;;;;;;;;;;;;;;;
undef("remapLL")
function remapLL(x[*][*]:numeric,y[*][*]:numeric)
local dims,nlat,nlon,dim_Names,newlat,newlon,dim_Names1,ui,uj,xo
begin
;;;;variable to;;;;;;;
  dims = dimsizes(x)
  nlat = dims(0)
  nlon = dims(1)
  dim_Names=getvardims(x)
  newlat=fspan(min(x&$dim_Names(0)$),max(x&$dim_Names(0)$),nlat)
  newlon=fspan(min(x&$dim_Names(1)$),max(x&$dim_Names(1)$),nlon)
;;;;;Variable from;;;;;;;
  dim_Names1=getvardims(y)
  ui=y&$dim_Names1(0)$  ;;lat
  uj=y&$dim_Names1(1)$  ;;lon
  xo=linint2(uj,ui,y,True,newlon,newlat,-999)
  copy_VarAtts(x,xo)
  copy_VarCoords(x,xo)
  return(xo)
end
;;;;;;;;;;;;;;;;;;;;
;;Function maskingLL
;;;;;;;;;;;;;;;;;;;;
undef("maskingLL")
function maskingLL(x[*][*]:numeric,y[*][*]:numeric)
local yo
begin
  print(";;;;;;; note : dimensions should be same size")
  yo=where(.not.ismissing(x),y,-999)
  copy_VarAtts(x,yo)
  copy_VarCoords(x,yo)
  return(yo)
end
;;;;;;;;;;;;;;;;;;;
;;;Function read
;;;;;;;;;;;;;;;;;;;
undef("readnc")
function readnc(x:string)
local a
begin
  a = addfile(x,"r")
;    print(getfilevarnames(a))
  return(a)
end
;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;
undef("prate")
function prate(x[*][*][*]:numeric)
local dims,ntime,ntJump
begin
  dims = dimsizes(x)
  ntime = dims(0)
  ntJump = 8 ; 3-hrly values
;;;;;;;;;;;;;;;;;  
y=x(:,:,:)   ;;defining rf variable
;;;;;;;calculating preciptation_rate ;;;;;;;;;
do i=1,ntime-1
   y(i,:,:)=x(i,:,:) - x(i-1,:,:)
 end do
 return(y)
 end
; ;;;;;;;;;;;;;;;;;;
; ;; Function 3htlytodaily
; ;;;;;;;;;;;;;;;;;;
 undef("acctodaily")
function acctodaily(x[*][*][*]:numeric)
local dims,ntime,nlat,nlon,ntJump,rf_daily,ntStrt,ntLast,nt
begin
  dims = dimsizes(x)
  ntime = dims(0)
  nlat = dims(1)
  nlon = dims(2)
  ntJump = 8 ; 3-hrly values
;;;;;;;;;;;;;;;;;  
y=x(:,:,:)   ;;defining rf variable
;;;;;;;calculating preciptation_rate ;;;;;;;;;
do i=1,ntime-1
   y(i,:,:)=x(i,:,:) - x(i-1,:,:)
end do
;;;;;;;;;;; converting to daily;;;;;;;;;;;;;; 
  rf_daily = y(:ntime-2:ntJump,:,:)  ;; defining rf_daily variable
 	  ntStrt = 0
 	  ntLast = ntJump-1
 do nt=0,ntime-2,ntJump 
   rf_daily(nt/ntJump,:,:) = (/ dim_sum_n(y(ntStrt:ntLast,:,:), 0) /)
   ntStrt = ntStrt+ntJump
   ntLast = ntLast+ntJump
 end do
 return(rf_daily)
 end
; ;;;;;;;;;;;;;;;;;;
; ;; Function 3htlytodaily
; ;;;;;;;;;;;;;;;;;;
 undef("todaily")
function todaily(x[*][*][*]:numeric)
local dims,ntime,nlat,nlon,ntJump,rf_daily,ntStrt,ntLast,nt
begin
  dims = dimsizes(x)
  ntime = dims(0)
  nlat = dims(1)
  nlon = dims(2)
  ntJump = 8 ; 3-hrly values
;;;;;;;;;;;;;;;;;  
;;;;;;;;;;; converting to daily;;;;;;;;;;;;;; 
  rf_daily = x(:ntime-2:ntJump,:,:)  ;; defining rf_daily variable
 	  ntStrt = 0
 	  ntLast = ntJump-1
 do nt=0,ntime-2,ntJump 
   rf_daily(nt/ntJump,:,:) = (/ dim_sum_n(x(ntStrt:ntLast,:,:), 0) /)*3
   ntStrt = ntStrt+ntJump
   ntLast = ntLast+ntJump
 end do
 return(rf_daily)
 end
; ;;;;;;;;;;;;;;;;;;
; ;; Function 3htlytodaily
; ;;;;;;;;;;;;;;;;;;
 undef("todailyTLLL")
function todailyTLLL(x[*][*][*][*]:numeric)
local dims,ntime,nlevel,nlat,nlon,ntJump,daily,ntStrt,ntLast,nt
begin
  dims = dimsizes(x)
  ntime = dims(0)
  nlevel= dims(1)
  nlat = dims(2)
  nlon = dims(3)
    ntJump = 8 ; 3-hrly values
;;;;;;;;;;;;;;;;;  
;;;;;;;;;;; converting to daily;;;;;;;;;;;;;; 
daily = x(:ntime-2:ntJump,:,:,:)  ;; defining rf_daily variable
 	  ntStrt = 0
 	  ntLast = ntJump-1
 do nt=0,ntime-2,ntJump 
   daily(nt/ntJump,:,:,:) = (/ dim_sum_n(x(ntStrt:ntLast,:,:,:), 0) /)*3
   ntStrt = ntStrt+ntJump
   ntLast = ntLast+ntJump
 end do
 return(daily)
 end
  
;;;;;;;;;;;;;;;;;;;;;;
;;; bias
;;;;;;;;;;;;;;;;;;;;;; 
undef("bias")
function bias(x[*][*]:numeric,y[*][*]:numeric)
local c
begin
  c= x-y
  copy_VarAtts(x,c)
  copy_VarCoords(x,c)
  return(c)
end
;;;;;;;;;;;
;;;Percentile
;;;;;;;;;;;
   undef("Percentile")
   function Percentile(x:numeric,P:float)
   begin
   if(P.gt.0) then
   P = P/100.
   end if
   x@_FillValue = default_fillvalue(typeof(x))
;   print("Rain rates for project greater than 0 and less than 1000...")
   x = where((x.gt.0 .and. x.lt.1000),x,x@_FillValue)
   index = round(P*dimsizes(x),3)
 ;  print("Index of percentile: "+index+ " of size: "+dimsizes(x))
   ib = dim_pqsort(x,2)
  ; print("The "+P*100+" percentile: "+x(index))
   return(x(index))
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;          WRF functions        ;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
undef("wrfdaily")
function wrfdaily(nc_file)  ;;;;;;;;;;;;;;;;;;;;;;
local times,rain_exp,rain_con,rain,rf,rf_daily
begin
times = wrf_user_getvar(nc_file,"times",-1)
rain_exp = wrf_user_getvar(nc_file,"RAINNC",-1)
rain_con = wrf_user_getvar(nc_file,"RAINC",-1)
rain= rain_exp + rain_con
rain@description = "Precipitation(mm/h)"
rf=prate(rain)
copy_VarCoords(rain_exp,rf)
rf&Time = wrf_times_c(nc_file->Times, 0)  ; convert to "hours since"
rf_daily=calculate_daily_values(rf,"sum",0,False)
rf_daily@description = "Precipitation(mm/day)"
return(rf_daily)
end

;;;;;;;;;;;;;;;
undef("wrfprate")
function wrfprate(nc_file)  ;;;;;;;;;;;;;;;;;;;;;;
local times,rain_exp,rain_con,rain,rf,rf_daily
begin
times = wrf_user_getvar(nc_file,"times",-1)
rain_exp = wrf_user_getvar(nc_file,"RAINNC",-1)
rain_con = wrf_user_getvar(nc_file,"RAINC",-1)
rain= rain_exp + rain_con
rain@description = "Precipitation(mm/h)"
rf=prate(rain)
copy_VarCoords(rain_exp,rf)
rf&Time = wrf_times_c(nc_file->Times, 0)  ; convert to "hours since"
return(rf)
end
;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;
;;getind_latlon1d
;;;;;;;;;;;;;;;;;;;;
  
; undef("getind_latlon1d")
; function getind_latlon1d(lat1d[*]:numeric,lon1d[*]:numeric \
;                         ,LAT[*]:numeric, LON[*]:numeric)
; local N, ij, dist, mndist, indx, nLon, nLat, xx
; begin
;   N  = dimsizes( LAT )          
;   ij = new ( (/N,2/) , typeof(N))
;   nLat =dimsizes(lat1d)
;   nLon =dimsizes(lon1d)
;   xx= new((/nLat,nLon/),typeof(N))
;   n2d    = dimsizes( xx )    

;   do n=0,N-1
;      dist   = gc_latlon(LAT(n),LON(n),lat1d(n),lon1d(n), 2,2)
;      mndist = min( dist )
;      ind1d  = ind(dist.eq.mndist)
;      if (.not.ismissing(ind1d(0))) then
;          ij(n,:) = ind_resolve( ind1d(0), n2d )
;      else
;          print("getind_latlon2d: lat="+ LAT(n)+"  lon="+ LON(n)+" problem")
;      end if

;      delete(mndist)
;      delete(ind1d)
;   end do
;   ij@long_name = "indices closest to specified LAT/LON coordinate pairs"

;   if (.not.any(ismissing(ij))) then
;       delete(ij@_FillValue)
;   end if
     
;   return( ij )
; end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;;;;;;;;;;;;;;;;
; ;; Function MMphtoMMpd
; ;;;;;;;;;;;;;;;;;;
; function MMphtoMMpd(x[*][*][*]:numeric,y[*][*][*]:numeric,njump:integer)
; ;;;;variable to;;;;;;;
;   dims = dimsizes(x)
;   ntime= dims(0)
;   nlat = dims(1)
;   nlon = dims(2)
;   rf_daily=
