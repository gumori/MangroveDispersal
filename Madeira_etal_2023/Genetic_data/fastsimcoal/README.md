<title>fastsimcoal projects</title>

DAF = joint derived allele frequency (DAF) spectrum of our populations, obtained with arlequin.

We ran 3 different models for each dataset (North, with populations 1-5, and South, with populations 6-11):
	- <i>direcional</i>, in which migration rates to west sites are 10 times higher than the opposite direction, based on predictions from oceanic currents;
	- <i>steppingstone</i>, in which propagules can only migrate to neighbouring sites;
	- <i>panmixia</i>, in which we calculate every migration rate without any constraints.
	
We also ran a full dataset simulation with the panmixia model.

Each directory stores the .tpl and .est files used in each simulation, the .bestlhoods of the best run and its AIC.