/*
 *        FILE: Boree mesh
 * DESCRIPTION: The Boree coaxial geometry. Consists of a 20mm diameter injector surrounded
 *              by a 150mm radius annulus (inner radius 75mm). The domain extends 500mm 
 *              downstream of the nozzle, and 200mm upstream.
 *
 *              The geometry is defined on the "zero plane" i.e. z=0. The inlet and outlet
 *              regions are then extruded from this plane.
 *
 *     CREATED: 04-FEB-2017
 *      AUTHOR: Paul Bartholomew
 *
 *     CHANGES: [04-FEB-2017] Defined zero plane.
 *              [04-FEB-2017] 2D meshing of zero plane.
 */

//
// Domain description
//

D_nozzle = 20.0e-3;
d_annulus = 150.0e-3;
D_annulus = 300.0e-3;
L_inlet = 200.0e-3;
L_outlet = 500.0e-3;

R_nozzle = 0.5 * D_nozzle;
r_annulus = 0.5 * d_annulus;
R_annulus = 0.5 * D_annulus;

r_ogrid = 0.5 * R_nozzle;
h_ogrid = Sqrt(0.5 * (r_ogrid * r_ogrid));

//
// Mesh parameters
//

n_theta = 10;   // The number of azimuthal cells per quarter circumference
n_nozzle = 10;  // The number of radial cells between the O-grid and the nozzle (should probably be approximately equal to n_theta)
n_bluff = 32;   // The number of radial cells covering the bluff body
n_annulus = 37; // The number of radial cells covering the annulus

prog_nozzle = 1.1; // The linear progression for the radial lines of the nozzle
bump_bluff = 1.0; // The bump for the radial lines of the bluff body
bump_annulus = 1.0; // The bump value for the radial lines of the annulus

//
// Draw the zero plane
//

Point(1) = {0.0, 0.0, 0.0, 1.0}; // Origin

// Corners of O-grid
Point(2) = {r_ogrid, 0.0, 0.0, 1.0};
Point(3) = {-r_ogrid, 0.0, 0.0, 1.0};
Point(4) = {0.0, r_ogrid, 0.0, 1.0};
Point(5) = {0.0, -r_ogrid, 0.0, 1.0};

// O-grid "centres" these are offset to give the arcs
Point(6) = {h_ogrid, h_ogrid, 0.0, 1.0};
Point(7) = {h_ogrid, -h_ogrid, 0.0, 1.0};
Point(8) = {-h_ogrid, -h_ogrid, 0.0, 1.0};
Point(9) = {-h_ogrid, h_ogrid, 0.0, 1.0};

// Draw the O-grid
Circle(1) = {4, 7, 3};
Circle(2) = {3, 6, 5};
Circle(3) = {5, 9, 2};
Circle(4) = {2, 8, 4};

// Outer diameter of injector
Point(10) = {R_nozzle, 0.0, 0.0, 1.0};
Point(11) = {-R_nozzle, 0.0, 0.0, 1.0};
Point(12) = {0.0, R_nozzle, 0.0, 1.0};
Point(13) = {0.0, -R_nozzle, 0.0, 1.0};

// Draw the circumference of the injector
Circle(5) = {13, 1, 11};
Circle(6) = {11, 1, 12};
Circle(7) = {12, 1, 10};
Circle(8) = {10, 1, 13};

// Connect injector to O-grid
// XXX these lines are oriented so that they will refine towards the walls
Line(9) = {10, 2};
Line(10) = {12, 4};
Line(11) = {11, 3};
Line(12) = {13, 5};

// Inner diameter of annulus
Point(14) = {r_annulus, 0.0, 0.0, 1.0};
Point(15) = {-r_annulus, 0.0, 0.0, 1.0};
Point(16) = {0.0, r_annulus, 0.0, 1.0};
Point(17) = {0.0, -r_annulus, 0.0, 1.0};

// Draw inner circumference of annulus
Circle(13) = {16, 1, 14};
Circle(14) = {14, 1, 17};
Circle(15) = {17, 1, 15};
Circle(16) = {15, 1, 16};

// Connect inner circumference of annulus to injector
// XXX lines oriented "pointing out", no reason to
//     favour one direction over another...
Line(17) = {10, 14};
Line(18) = {13, 17};
Line(19) = {11, 15};
Line(20) = {12, 16};

// Outer diameter of annulus
Point(18) = {R_annulus, 0.0, 0.0, 1.0};
Point(19) = {-R_annulus, 0.0, 0.0, 1.0};
Point(20) = {0.0, R_annulus, 0.0, 1.0};
Point(21) = {0.0, -R_annulus, 0.0, 1.0};

// Draw outer circumference of annulus
Circle(21) = {20, 1, 18};
Circle(22) = {18, 1, 21};
Circle(23) = {21, 1, 19};
Circle(24) = {19, 1, 20};

// Connect outer circumference to inner circumference of annulus
// XXX No reason to favour one orientation over another, points
//     "out"
Line(25) = {14, 18};
Line(26) = {17, 21};
Line(27) = {15, 19};
Line(28) = {16, 20};

//
// Mesh the zero plane (2D mesh)
//

// Defining surfaces
Line Loop(29) = {1, 2, 3, 4};
Plane Surface(30) = {29};
Line Loop(31) = {6, 10, 1, -11};
Plane Surface(32) = {31};
Line Loop(33) = {10, -4, -9, -7};
Plane Surface(34) = {33};
Line Loop(35) = {9, -3, -12, -8};
Plane Surface(36) = {35};
Line Loop(37) = {12, -2, -11, -5};
Plane Surface(38) = {37};
Line Loop(39) = {16, -20, -6, 19};
Plane Surface(40) = {39};
Line Loop(41) = {20, 13, -17, -7};
Plane Surface(42) = {41};
Line Loop(43) = {17, 14, -18, -8};
Plane Surface(44) = {43};
Line Loop(45) = {18, 15, -19, -5};
Plane Surface(46) = {45};
Line Loop(47) = {24, -28, -16, 27};
Plane Surface(48) = {47};
Line Loop(49) = {28, 21, -25, -13};
Plane Surface(50) = {49};
Line Loop(51) = {25, 22, -26, -14};
Plane Surface(52) = {51};
Line Loop(53) = {26, 23, -27, -15};
Plane Surface(54) = {53};

// Transfinite lines
Transfinite Line {4, 3, 2, 1, 6, 7, 8, 5, 16, 13, 14, 15, 24, 21, 22, 23} = n_theta + 1 Using Progression 1; // Circumferential lines, MUST ALL HAVE SAME NUMBER OF CELLS, NO PROGRESSION
Transfinite Line {10, 9, 12, 11} = n_nozzle + 1 Using Progression prog_nozzle; // Radial lines in nozzle
Transfinite Line {20, 17, 18, 19} = n_bluff + 1 Using Bump bump_bluff; // Radial lines in bluff body
Transfinite Line {28, 25, 26, 27} = n_annulus + 1 Using Bump bump_annulus; // Radial lines in annulus

// Transfinite surfaces
Transfinite Surface {30};
Transfinite Surface {32};
Transfinite Surface {34};
Transfinite Surface {36};
Transfinite Surface {38};
Transfinite Surface {46};
Transfinite Surface {40};
Transfinite Surface {42};
Transfinite Surface {44};
Transfinite Surface {48};
Transfinite Surface {50};
Transfinite Surface {52};
Transfinite Surface {54};

// Recombine surface
Recombine Surface {30, 38, 32, 34, 36, 46, 40, 42, 44, 54, 48, 50, 52};
