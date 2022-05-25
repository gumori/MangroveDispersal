from datetime import datetime, timedelta
import numpy as np
import opendrift
from opendrift.models.oceandrift import OceanDrift
from opendrift.readers import reader_netCDF_CF_generic
from opendrift.readers import reader_global_landmask

x = OceanDrift()
x.io_import_file('FLN_100k_11y.nc')

x.animation(filename='FLN_100k_11y.gif')
