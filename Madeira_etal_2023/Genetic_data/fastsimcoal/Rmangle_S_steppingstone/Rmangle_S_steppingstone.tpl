//Parameters for the coalescence simulation program : fastsimcoal.exe
7 samples to simulate :
//Population effective sizes (number of genes)
1000
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
20
0 T1
//Growth rates	: negative growth implies population expansion
0
0
0
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
2
//Migration matrix 0
0	M0I	0	0	0	0	0
MI0	0	MI2	0	0	0	0
0	M2I	0	M23	0	0	0
0	0	M32	0	M34	0	0
0	0	0	M43	0	M45	0
0	0	0	0	M54	0	0
0	0	0	0	0	0	0
//Migration matrix 1
0	0	0	0	0	0	0
0	0	0	0	0	0	0
0	0	0	0	0	0	0
0	0	0	0	0	0	0
0	0	0	0	0	0	0
0	0	0	0	0	0	0
0	0	0	0	0	0	0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
6 historical event
T1 0 6 1 1 0 1
T1 1 6 1 1 0 1
T1 2 6 1 1 0 1
T1 3 6 1 1 0 1
T1 4 6 1 1 0 1
T1 5 6 1 1 0 1
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ 1 0 2.5e-8