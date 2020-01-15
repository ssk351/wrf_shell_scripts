;;;;;
;;This script will give the no of points for the domians
;;;;;

begin
  cf =111.1
  dx = (/27,9,3/) ;; km domain resolution                                                                                                                  

  lats_min=(/4,22,28/)	;domains minimum latitudes                                                                                                         
  lats_max=(/45,40,38/) ;domains maximum                                                                                                                   
  lons_min=(/61,65,71/)	;domains minimum longitudes                                                                                                        
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
    print("===========")

    delete([/no_sn,no_we/])
  end do

end
