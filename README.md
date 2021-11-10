# statistical-mapmatching-minsolv

This repository contains a number of minimal solvers for 3D point cloud matching with statistical deformations. The matching is done between two point clouds using 3 or 4 point pairs. These points are allowed to deform in the direction of the largest modes of variation (i.e. the modes of variation corresponding to the largest eigenvalues for the covariance matrices). Both the position of the points and the modes are sent in to the solvers.

Solver x-a-b is a solver using x points, a modes from the first map and b modes from the second map. The solver file for solver x-a-b is called solver_3dreg_xab.m.

The solvers have originally been created using an automatic generator[^1], and the corresponding problem files in the foder ```problems```. The function ```benchmark_solver.m``` comes from their code[^2]. Thereafter the solvers have been updated manually. The final solvers can be found in the folder ```solvers```. 

To run experiments on a number of simulated problem instances and generate a histogram to show the numerical stability for the solvers, run the file ```main.m```.

In the main function, choose whether you want to run "slow" solvers or not. Also, set a desirable number of iterations.

To use the solvers for point matching,  the input should be the points and the modes column stacked, with the points from map 1 first, then the modes from map 1, followed by the points and the modes for map 2. Note that to use the solvers for certain point matching problem, the multipol class is not needed.

[^1]: Larsson, V., Astrom, K. and Oskarsson, M., 2017. Efficient solvers for minimal problems by syzygy-based reduction. In *Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition* (pp. 820-829).
[^2]: Downloaded from http://people.inf.ethz.ch/vlarsson/misc/autogen_v0_5.zip (March 2021)
