//Parameters for the coalescence simulation program : fastsimcoal.exe
13 samples to simulate :
//Population effective sizes (number of genes)
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
20000000
20000000
//Samples sizes and samples age 
20
20
20
20
20
20
20
20
20
20
20
0 T1
0 T2
//Growth rates	: negative growth implies population expansion
0
0
0
0
0
0
0
0
0
0
0
0
0
//Number of migration matrices : 0 implies no migration between demes
3
//Migration matrix 0
0	M0I	M02	M03	M04	0	0	0	0	0	0	0	0
MI0	0	MI2	MI3	MI4	0	0	0	0	0	0	0	0
M20	M2I	0	M23	M24	0	0	0	0	0	0	0	0
M30	M3I	M32	0	M34	0	0	0	0	0	0	0	0
M40	M4I	M42	M43	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	M56	M57	M58	M59	M510	0	0
0	0	0	0	0	M65	0	M67	M68	M69	M610	0	0
0	0	0	0	0	M75	M76	0	M78	M79	M710	0	0
0	0	0	0	0	M85	M86	M87	0	M89	M810	0	0
0	0	0	0	0	M95	M96	M97	M98	0	M910	0	0
0	0	0	0	0	M105	M106	M107	M108	M109	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
//Migration matrix 1
0	M0I	M02	M03	M04	0	0	0	0	0	0	0	0
MI0	0	MI2	MI3	MI4	0	0	0	0	0	0	0	0
M20	M2I	0	M23	M24	0	0	0	0	0	0	0	0
M30	M3I	M32	0	M34	0	0	0	0	0	0	0	0
M40	M4I	M42	M43	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
//Migration matrix 2
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0
//historical event: time, source, sink, migrants, new deme size, new growth rate, migration matrix index
13 historical event
T1 5 11 1 1 0 1
T1 6 11 1 1 0 1
T1 7 11 1 1 0 1
T1 8 11 1 1 0 1
T1 9 11 1 1 0 1
T1 10 11 1 1 0 1
T1 11 11 0 0.0001 0 1
T2 0 12 1 1 0 2
T2 1 12 1 1 0 2
T2 2 12 1 1 0 2
T2 3 12 1 1 0 2
T2 4 12 1 1 0 2
T3 11 12 1 1 0 2
//Number of independent loci [chromosome] 
1 0
//Per chromosome: Number of contiguous linkage Block: a block is a set of contiguous loci
1
//per Block:data type, number of loci, per generation recombination and mutation rates and optional parameters
FREQ 1 0 2.5e-8