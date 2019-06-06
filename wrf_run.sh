#;;;;; This script run WRF model;;;;;;;;;;;;
#!/bin/bash
#;########################################################################################
# the following steps are follwed
#;;; 1. WPS
#;;; 2. WRFV3
#;#########################################################################################

echo -n "\n   !!!!!!!!!!      Welcome to "${USER}"'s PC   !!!!!!!!!!!! \n"
echo -n "\n   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n "
echo -n "\n                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^              \n"
echo -n "\n   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n "
echo -n "\n               The verssion which you are running is ARW 3.8\n\n"
echo "\n                    Current directory : ${PWD}"
#;;;;''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''';;;;#

##   NOTE:            %%%%%%         Give your respective Paths       %%%%%%%               #

export wps_dir=/home/sai/wrf/build_wrf/WPS
export data_dir=/home/sai/Documents/fnl_data/after_fani/fnl_20190501-20190509
export wrf_dir=/home/sai/wrf/build_wrf/WRFV3/test/em_real

##                %%%%%%          xxxxxxxxxxxxxxxxxxxxxxxxxx      %%%%%%                 #
echo "\n ;;;;;;;;;;;;;;;;;;;;;;;;;;you r working for the region;;;;;;;;;;;;;;;;;;;;;;;;;;\n"

## ;;;;;;;;;;;;;;;;;;;;;;;;;;; to see the Domain ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
ncl ${wps_dir}/plotgrids_new.ncl
gpicview ${wps_dir}/wps_show_dom.png

exes="$(ls ${wps_dir}/*.exe |wc -l)"

if [ "${exes}"-eq"3" ];then
    echo "\n\t                      Executables are existed are "${exes}
    echo "\n ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    echo " \n$(ls *.exe)"
else
    echo "executables are missed"
fi

echo "\n  -----------------------  Geogrid is Running  ------------------------------\n\n"
${wps_dir}/./geogrid.exe
echo "\n -------------------------  Geogrid is successfully completed  ---------------\n\n"


echo "\n  ---------------------X--  Data Linking       -X-----------------------------\n\n"

${wps_dir}/./link_grib.csh ${data_dir}/* .
echo "\n  ----------------------X-  Data successfully Linked -X---------------------\n\n"


echo "\n  ---------------------X--  Ungrib is Running  -X-----------------------------\n\n"


${wps_dir}/./ungrib.exe
echo "\n  ---------------------X-  Ungrib is successfull  -X-------------------------\n\n"


echo "\n  ----------------------X-  Metgrid is Running  -X---------------------------\n\n"

${wps_dir}/./metgrid.exe

 echo "\n  ---------------------X-  Metgrid is successfull  -X------------------------\n\n"
 echo "\n ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
 echo "\n ;;;;;;;;;;;;;;;;;;;;; WPS COMPLETED SUCCESSFULLY  ;;;;;;;;;;;;;;;;;;;;;;;\n"
 echo "\n ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"

 echo "\n  ---------------------X- WPS  created file  -X-----------------------------\n\n"

 echo "$(ls ${wps_dir}/geo_*.nc)\n"
 echo "$(ls ${wps_dir}/GRIB*)\n"
 echo "$(ls ${wps_dir}/*FILE*)\n"
 echo "$(ls ${wps_dir}/met*.nc)\n"

#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#                                   Runnig ARW
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


echo "\n ^^^^^^^^^^^^^^^^^^^^^^  Linking WPS Data to Model ^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
cd ${wrf_dir}
echo "\n ^^^^^^^^^^^^^^^^^^^^^^  Running Real .exe   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"

ln -sf ${wps_dir}/met_em* .
${wrf_dir}/./real.exe > real.log
echo "$(ls ${wrf_dir}/wrfbdy*)\n"

echo "\n  -----X--  Boundary conditions and input conditions are Ready  --X------------\n"

echo "\n ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,  END  ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,\n"











