from datetime import datetime, timedelta
import numpy as np
import opendrift
from opendrift.models.oceandrift import OceanDrift
from opendrift.readers import reader_netCDF_CF_generic
from opendrift.readers import reader_global_landmask

a = OceanDrift()

main_reader = reader_netCDF_CF_generic.Reader('Brazil_10-21.nc', standard_name_mapping={'u':'x_sea_water_velocity', 'v':'y_sea_water_velocity'})

a.add_reader([main_reader])

#coordenadas modificadas pra sair da baía: -22.973056, -43.133349
a.seed_elements(lon=316.866651, lat=-22.973056, z=-15, number=100000, radius=1000, time=[main_reader.start_time, main_reader.end_time-timedelta(weeks=52)])

#8766 passos = 1 ano (8766 horas)
a.run(steps=96360, outfile='GPM_100k_11y.nc', export_variables=[], time_step_output=timedelta(weeks=1))

a.animation(filename='GPM_100k_11y.gif')
