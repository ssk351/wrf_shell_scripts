load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/sai_scripts/regrid.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"
loadscript ("./module_basemap_mpres.ncl")
begin
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; We generate plots, but what kind do we prefer?
type = "png"
; type = "pdf"
; type = "ps"
; type = "ncgm"
wks = gsn_open_wks(type,"preci_new")
  diri="./"
  file1="wrfout_d02_USGS.nc"
  file2="wrfout_d02_NRSC.nc"
;  print("working with:"+filename+"")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=addfile(diri+file1,"r")
b=addfile(diri+file2,"r")
;;;;;;;;;;;;;;;;;;;;;;
times = wrf_user_getvar(a,"times",-1)
rain_exp = wrf_user_getvar(a,"RAINNC",-1)
rain_con = wrf_user_getvar(a,"RAINC",-1)
rain1= rain_exp + rain_con
rain1@description = "Precipitation(mm/h)"
rf_usgs=prate(rain1)
copy_VarCoords(rain_exp,rf_usgs)
rf_usgs&Time = wrf_times_c(a->Times, 0)  ; convert to "hours since"
usgs=calculate_daily_values(rf_usgs,"sum",0,False)
usgs@description = "Precipitation(mm/day)"

;printVarSummary(usgs)
;exit
;printMinMax(usgs,False)
;;;;;;;;;;;;;;;;;;;;;
delete([/rain_exp,rain_con/])
rain_exp = wrf_user_getvar(b,"RAINNC",-1)
rain_con = wrf_user_getvar(b,"RAINC",-1)
rain2= rain_exp + rain_con
rain2@description = "Precipitation(mm/h)"
;;;;;;;;;;;;;;;;;;;;;
rf_nrsc=prate(rain2)

copy_VarCoords(rain_exp,rf_nrsc)
rf_nrsc&Time = wrf_times_c(a->Times, 0)  ; convert to "hours since"
nrsc=calculate_daily_values(rf_nrsc,"sum",0,False)
nrsc@description = "Precipitation(mm/day)"
printMinMax(usgs,False)
printMinMax(nrsc,False)
;rf_bias = rf_nrsc-rf_usgs
;ntime =dimsizes(times)/8
mpres@tfDoNDCOverlay=True
mpres@cnFillOn =True
mpres@cnLinesOn=False
mpres@cnLineLabelsOn=False
mpres@cnLevelSelectionMode = "ExplicitLevels"
mpres@cnLevels =(/0.1,20,40,60,90,120,150,200,250,300/)
;mpres@cnLevels = (/0.1,2,4,8,16,32/)
mpres@cnFillPalette       ="precip2_17lev"

mpres@lbLabelBarOn        = False           ; turn off individual cb's
mpres=wrf_map_resources(a,mpres)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plota=new(10,graphic)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    time=cd_calendar(usgs&Time,2)
 do i=0,4;dimsizes(pcp_08(:,0,0))-1
 ;  mpres@gsnCenterString =""+time(i)+""
   plota(i)=gsn_csm_contour_map(wks,usgs(i,:,:),mpres)
 end do
 do i=5,9;dimsizes(pcp_08(:,0,0))-1
;   mpres@gsnCenterString =""+time(i)+""
   plota(i)=gsn_csm_contour_map(wks,nrsc(i-5,:,:),mpres)
 end do

resP=True
 resP@gsnPanelLabelBar    = True
 resP@lbOrientation   ="Horizontal"
 resP@pmLabelBarParallelPosF = 0.04
 resP@pmLabelBarOrthogonalPosF=-0.05
 
; resP@gsnPanelFigureStrings=(/"a","b","c","d","e","f"/)
 resP@gsnMaximize=True
 resP@gsnPaperOrientation="landscape";maximize the plot
gsn_panel(wks,plota,(/2,5/),resP)    ;plot 1,2... are list of plots (/1,2/

end
