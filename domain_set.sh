#/bin/bash
# to set domain

# constants
cf=111  #;;deg=111.1
dx_out=6     #;;in km
dx_in=2      
lat_out_min=10
lon_out_min=60
lat_out_max=40
lon_out_max=100
#;;;;;;;;;;;;
lat_in_min=27
lon_in_min=75
lat_in_max=36
lon_in_max=82


echo ";;;;;;;;;;"
#;;;;;;;;;; Outer domain points;;;;;;;;;
echo ";;;;;;;;;;"
echo "Outer domain points"          ##;;;;Domain_1
no_sn_point_out=$(((lat_out_max - lat_out_min)*cf/dx_out))  # 
no_we_point_out=$(((lon_out_max - lon_out_min)*cf/dx_out))

echo "sn:"$no_sn_point_out "and we:"$no_we_point_out
#;;;;;;;;;; Inner domain points;;;;;;;;;
echo ";;;;;;;;;;"
echo "Inner domain points"          ##;;;Domain_2

no_sn_point_in=$(((lat_in_max - lat_in_min)*cf/dx_in))  # 
no_we_point_in=$(((lon_in_max - lon_in_min)*cf/dx_in))

echo "sn:"$no_sn_point_in "and we:"$no_we_point_in
echo ";;;;;;;;;;"

ref_lat=23
ref_lon=85

new_lat_min=$((ref_lat-6))
new_lat_max=$((ref_lat+6))

new_lon_min=$((ref_lon-6))
new_lon_max=$((ref_lon+6))

# echo $new_lat_min
# echo $new_lat_max
# echo $new_lon_min
# ;;;;;;;;;; moving domain ;;;;;
echo "moving domain points"
new_no_sn_point_in=$(((new_lat_max - new_lat_min)*cf/dx_in))  # 
new_no_we_point_in=$(((new_lon_max - new_lon_min)*cf/dx_in))
echo "sn:"$new_no_sn_point_in "and we:"$new_no_we_point_in

# i,j_start_positions
echo "moving_nest_location"
i_start=$(((new_lon_min-lon_min)*cf/dx_out))
j_start=$(((new_lat_min-lat_min)*cf/dx_out))
echo "i_start:"$i_start "and j_start:"$j_start

