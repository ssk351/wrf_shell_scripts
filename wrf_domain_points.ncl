;;;;;;;;;;;;;;;;;;;;;;
;;This script is to calculate the namelist.wps input data
;;;;;;;;;;;;;;;;;;;;;;

begin
  cf =111.1
  dx = (/27,9,3/) ;; km domain resolution
  
  lats_min=(/4,22,28/)  ;domains minimum latitudes
  lats_max=(/45,40,38/) ;domains maximum 
  lons_min=(/61,65,71/) ;domains minimum longitudes
  lons_max=(/105,90,82/);domains maxmimum

  
  do i=0,dimsizes(dx)-1

    print("No of points for "+dx(i)+"km domain")
    print("===========")
    
;;;;;;;
    no_sn=((lats_max(i) - lats_min(i))*cf/dx(i))  
    no_we=((lons_max(i) - lons_min(i))*cf/dx(i))
    
;;;;;;;

    print("e_sn:  "+no_sn+"")
    print("e_we:  "+no_we+"")

    if (dx(i) .eq. dx(0))
      i_start =1
      j_start =1
      ref_lat=tofloat((lats_max(0)+lats_min(0))/2)
      ref_lon=tofloat((lons_max(0)+lons_min(0))/2)
      print("i_start : "+i_start+"")
      print("j_start : "+j_start+"")
      print("ref_lat : "+ref_lat+"")
      print("ref_lat : "+ref_lon+"")

    end if
    
    if (i.eq.1)
      i_start= (lons_min(1)-lons_min(0))*cf/dx(0)
      j_start= (lats_min(1)-lats_min(0))*cf/dx(0)
      print("i_start : "+i_start+"")
      print("j_start : "+j_start+"")
    end if
    
    if (i.eq.2)
      i_start= (lons_min(2)-lons_min(1))*cf/dx(1)
      j_start= (lats_min(2)-lats_min(1))*cf/dx(1)
      print("i_start : "+i_start+"")
      print("j_start : "+j_start+"")
    end if
    
    if (i.eq.3)
      i_start= (lons_min(3)-lons_min(2))*cf/dx(2)
      j_start= (lats_min(3)-lats_min(2))*cf/dx(2)
      print("i_start : "+i_start+"")
      print("j_start : "+j_start+"")
    end if

    print("===========")

    delete([/no_sn,no_we,i_start,j_start/])
  end do

end
