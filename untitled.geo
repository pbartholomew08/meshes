/*
 *        FILE: Boree mesh
 * DESCRIPTION: The Boree coaxial geometry. Consists of a 20mm diameter injector surrounded
 *              by a 150mm radius annulus (inner radius 75mm). The domain extends 500mm 
 *              downstream of the nozzle, and 200mm upstream.
 *     CREATED: 04-FEB-2017
 *      AUTHOR: Paul Bartholomew
 *
 *     CHANGES:
 */

// Domain description
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
