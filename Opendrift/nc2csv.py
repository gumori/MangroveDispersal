import xarray as xr
import pandas as pd

#open the netcdf and turn it into dataframe
ds = xr.open_dataset('PRC_100k_11y.nc')
df = ds.to_dataframe()

#delete rows of elements that are already deactivated
df = df.loc[df["status"] != -2147483647]

#now we want to exclude elements that drifted for more than one year (>52 entries)
#first, create vector with number of entries for each element
vector = df.groupby(level=[0]).size()

#create another vector with the elements with >52 entries
vector2 = vector.loc[lambda x: x>52].index

#drop the respective rows from dataframe
df = df.drop(index=vector2)

#retain only the rows with the last information available for deactivated elements
df = df.loc[df["status"] == 1]

#export to .csv
df.to_csv('PRC_100k_11y.csv', columns=['lon', 'lat'])
