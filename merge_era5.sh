#!/bin/bash

# put era5 in MONARCHS format

for var in \
  10m_v_component_of_wind \
  10m_u_component_of_wind 
  2m_temperature \
  2m_dewpoint_temperature \
  snowfall \
  surface_pressure \
  surface_solar_radiation_downwards \
  surface_thermal_radiation_downwards
do
  echo "Processing: $var"
  cdo mergetime era5_{2013..2024}_"$var".nc "era5_2013_2024_${var}.nc"
done
  

cdo merge \
  era5_2013_2024_2m_temperature.nc \
  era5_2013_2024_2m_dewpoint_temperature.nc \
  era5_2013_2024_10m_v_component_of_wind.nc \
  era5_2013_2024_10m_u_component_of_wind.nc \
  era5_2013_2024_surface_solar_radiation_downwards.nc \
  era5_2013_2024_surface_thermal_radiation_downwards.nc \
  era5_2013_2024_surface_pressure.nc \
  era5_2013_2024_snowfall.nc \
  era5_2013_2024_merged.nc

# netcdf operators work better with time dim 'time' than 'valid_time'
#ncrename -v valid_time,time -d valid_time,time era5_2013_2024_merged.nc era5_2013_2024_merged_dimtime.nc