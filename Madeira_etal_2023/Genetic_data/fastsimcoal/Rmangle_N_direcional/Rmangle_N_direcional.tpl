//Parameters for the coalescence simulation program : fastsimcoal.exe
6 samples to simulate :
//Population effective sizes (number of genes)
1000
1000
1000
1000
1000
20000000
//Samples sizes and samples age 
20
20
20
20
20
0 T1
//Growth rates	: negative growth implies population expansion
0
0
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0	M0I	M02	M03	M04	0
MI0	0	MI2	MI3	MI4	0
M20	M2I	0	M23	M24	0
M30	M3I	M32	0	M34	0
M40	M4I	M42	M43	0	0
0	0	0	0	0	0
//Migration matrix 1
0	0	0	0	0	0
0	0	0	0	0	0
0	0	0	0	0	0
0	0	0	0	0	0
0	0	0	0	0	0
0	0	0	0	0	0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
5 historical event
T1 0 5 1 1 0 1
T1 1 5 1 1 0 1
T1 2 5 1 1 0 1
T1 3 5 1 1 0 1
T1 4 5 1 1 0 1
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ 1 0 2.5e-8