
begin
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
res=True
pltres=True
mpres=True
opts_r = res

opts_r@cnFillPalette       ="precip3_16lev";"perc2_9lev"
 opts_r@cnLevelSelectionMode = "ExplicitLevels"
 opts_r@cnLevels             = (/0.1,5,10,15,20,30,40,60,80,100,120/)
; opts_r@cnFillColors         = (/"White","Yellow","Chartreuse","ForestGreen","skyblue","royalblue","chocolate4","red"/)
;(/ .1, .2, .4, .8, 1.6, 3.2, 6.4, \
;                               12.8, 25.6, 51.2, 102.4/)
      ; opts_r@cnFillColors         = (/"White","DarkOliveGreen1", \
      ;                                "DarkOliveGreen3","Chartreuse", \
      ;                               "Chartreuse3","Green","ForestGreen", \;
      ;                               "Yellow","Orange","Red","Violet"/)

opts_r@cnInfoLabelOn        = False
opts_r@cnConstFLabelOn      = False
opts_r@cnFillOn             = True
      opts_r@lbLabelBarOn         =False
;opts_r@lbOrientation      ="Vertical"
opts_r@NoHeaderFooter       =True
opts_r@FieldTitle 	  =""
mpres = True
mpres@mpDataBaseVersion           = "Ncarg4_1"
mpres@cnFillOn =True
mpres@mpOutlineBoundarySets       = "AllBoundaries"
mpres@mpGeophysicalLineColor      = "black"
mpres@mpNationalLineColor         = "black"
mpres@mpGeophysicalLineThicknessF = 8.0
mpres@mpNationalLineThicknessF    = 8.0
mpres@tmXBLabelFont 			="helvetica-bold"
mpres@tmYLLabelFont 			="helvetica-bold"
mpres@tmXBLabelFontHeightF  		=0.02
mpres@tmYLLabelFontHeightF  		=0.02
mpres@tmYLMinorOn 			= False
mpres@tmXBMinorOn 			=False
mpres@mpMinLatF      = 15
 mpres@mpMaxLatF      =20
 mpres@mpMinLonF      =80
 mpres@mpMaxLonF      =90

  times = wrf_user_getvar(a,"times",-1)
tes = wrf_user_getvar(a,"RAINNC",-1); Precip
tes@lat2d= wrf_user_getvar(a,"XLAT",0)
tes@lon2d= wrf_user_getvar(a,"XLONG",0)

ntimes=dimsizes(times)
precip = tes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; First get the variables we will need
; Get non-convective, convective
; Calculate total precipitation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
do it=1,ntimes-1
  rainnc = wrf_user_getvar(a,"RAINNC",it); Precip
  rainc = wrf_user_getvar(a,"RAINC",it) ; Some other precip variable
  rainnc_old=wrf_user_getvar(a,"RAINNC",it-1)
  rainc_old=wrf_user_getvar(a,"RAINC",it-1)
  precip(it,:,:) = rainnc+rainc-rainnc_old-rainc_old    ;;precipitation rate
  delete([/rainnc,rainnc_old,rainc,rainc_old/])
  precip@description="PRECIPTATION RATE"
  precip@units     = "mm/hr"
end do

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; converting to Daily
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
delete([/ntimes,it/])
njump = 8
;;;;;;;;;;;;;;;;;;;;;;;
;; from 3hrly to daily
;; from 6hyly to daily
;;;;;;;;;;;;;;;;;;;;;;;
ntimes =dimsizes(times)/8
precip_daily=precip(::njump,:,:)
do it=0,ntimes-1,njump
  nstart=0
  nlast=njump-1
  precip_daily(it,:,:)=dim_avg_n_Wrap(precip(nstart:nlast,:,:),0)
  nstart=nstart+njump
  nlast =nlast+njump
  precip_daily@description = "DAILY PRECIPTATION"
  precip_daily@units       = "mm/day"

end do  
end
