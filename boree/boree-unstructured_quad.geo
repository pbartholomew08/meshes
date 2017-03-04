// Boree mesh using untructured quads for the 2D mesh
// The 3D extrapolation is "structured" in the z direction.

r = 10.0e-3;
yp_inner = 2.0e-3;

rr = 75.0e-3;
yp_bluff = 1.5e-3;

R = 150.0e-3;
yp_annulus = 1.5e-3;

n = 4;
nn = 30;
N = 60;

L_in = 200e-3;
L_out = 500e-3;

dz = 3.5e-3;
n_in = Floor(L_in / dz);
n_out = Floor(L_out / dz);

/*
 * The injector:
 *
 *   A central unstructured mesh is surrounded by a structured boundary layer. This is to ensure
 *   that yplus is 30 which means the first point must be 2 mm from the surface.
 */

Point(1) = {0, 0, 0, 1.0};
Point(2) = {(r - 2 * yp_inner), 0, 0, 1.0};
Point(3) = {-(r - 2 * yp_inner), 0, 0, 1.0};
Point(4) = {0, (r - 2 * yp_inner), 0, 1.0};
Point(5) = {0, -(r - 2 * yp_inner), 0, 1.0};

Circle(1) = {4, 1, 2};
Circle(2) = {2, 1, 5};
Circle(3) = {5, 1, 3};
Circle(4) = {3, 1, 4};

Point(6) = {r, 0, 0, 1.0};
Point(7) = {-r, 0, 0, 1.0};
Point(8) = {0, r, 0, 1.0};
Point(9) = {0, -r, 0, 1.0};

Line(5) = {4, 8};
Line(6) = {2, 6};
Line(7) = {3, 7};
Line(8) = {5, 9};

Circle(9) = {9, 1, 6};
Circle(10) = {6, 1, 8};
Circle(11) = {8, 1, 7};
Circle(12) = {7, 1, 9};

Line Loop(13) = {4, 1, 2, 3};
Plane Surface(14) = {13};
Line Loop(15) = {11, -7, 4, 5};
Plane Surface(16) = {15};
Line Loop(17) = {7, 12, -8, 3};
Plane Surface(18) = {17};
Line Loop(19) = {8, 9, -6, 2};
Plane Surface(20) = {19};
Line Loop(21) = {10, -5, 1, 6};
Plane Surface(22) = {21};

Transfinite Line {7, 5, 6, 8} = 2 Using Progression 1;
Transfinite Line {11, 4, 1, 10, 9, 2, 3, 12} = n + 1 Using Progression 1;
Transfinite Surface {16};
Transfinite Surface {22};
Transfinite Surface {20};
Transfinite Surface {18};
Recombine Surface {16, 14, 22, 20, 18};

/*
 * The bluff body:
 *
 *   Here the first point location is at 1.5 mm so we transition to have an azimuthal resolution
 *   of 3 mm corresponding to 29 cells per quarter circumference (we choose 30 because apparently gmsh's algorithm requires
 *   an even number of cells
 */
Point(10) = {rr, 0, 0, 1.0};
Point(11) = {-rr, 0, 0, 1.0};
Point(12) = {0, rr, 0, 1.0};
Point(13) = {0, -rr, 0, 1.0};

Circle(23) = {12, 1, 10};
Circle(24) = {10, 1, 13};
Circle(25) = {13, 1, 11};
Circle(26) = {11, 1, 12};

Line Loop(27) = {26, 23, 24, 25};
Line Loop(28) = {11, 12, 9, 10};
Plane Surface(29) = {27, 28};

Transfinite Line {26, 23, 24, 25} = nn + 1 Using Progression 1;
Recombine Surface {29};

/*
 * The annulus:
 *
 *   First, create the boundary layer around the bluff body, then the boundary layer within the annulus outer circumference.
 *   In both cases the first node should be at 1.5 mm.
 */
Point(14) = {(rr + 2 * yp_bluff), 0, 0, 1.0};
Point(15) = {-(rr + 2 * yp_bluff), 0, 0, 1.0};
Point(16) = {0, (rr + 2 * yp_bluff), 0, 1.0};
Point(17) = {0, -(rr + 2 * yp_bluff), 0, 1.0};

Circle(30) = {16, 1, 14};
Circle(31) = {14, 1, 17};
Circle(32) = {17, 1, 15};
Circle(33) = {15, 1, 16};

Line(34) = {16, 12};
Line(35) = {10, 14};
Line(36) = {13, 17};
Line(37) = {15, 11};

Line Loop(38) = {37, 26, -34, -33};
Plane Surface(39) = {38};
Line Loop(40) = {34, 23, 35, -30};
Plane Surface(41) = {40};
Line Loop(42) = {35, 31, -36, -24};
Plane Surface(43) = {42};
Line Loop(44) = {36, 32, 37, -25};
Plane Surface(45) = {44};

Transfinite Line {37, 34, 35, 36} = 2 Using Progression 1;
Transfinite Line {33, 30, 31, 32} = nn + 1 Using Progression 1;
Transfinite Surface {39};
Transfinite Surface {41};
Transfinite Surface {43};
Transfinite Surface {45};
Recombine Surface {39, 41, 43, 45};

Point(18) = {(R - 2 * yp_annulus), 0, 0, 1.0};
Point(19) = {-(R - 2 * yp_annulus), 0, 0, 1.0};
Point(20) = {0, (R - 2 * yp_annulus), 0, 1.0};
Point(21) = {0, -(R - 2 * yp_annulus), 0, 1.0};

Circle(46) = {20, 1, 18};
Circle(47) = {18, 1, 21};
Circle(48) = {21, 1, 19};
Circle(49) = {19, 1, 20};

Line Loop(50) = {49, 46, 47, 48};
Line Loop(51) = {33, 30, 31, 32};
Plane Surface(52) = {50, 51};

Transfinite Line {49, 46, 47, 48} = N + 1 Using Progression 1;
Recombine Surface {52};

Point(22) = {R, 0, 0, 1.0};
Point(23) = {-R, 0, 0, 1.0};
Point(24) = {0, R, 0, 1.0};
Point(25) = {0, -R, 0, 1.0};

Circle(53) = {24, 1, 22};
Circle(54) = {22, 1, 25};
Circle(55) = {25, 1, 23};
Circle(56) = {23, 1, 24};

Line(57) = {23, 19};
Line(58) = {24, 20};
Line(59) = {18, 22};
Line(60) = {21, 25};

Line Loop(61) = {46, 59, -53, 58};
Plane Surface(62) = {61};
Line Loop(63) = {59, 54, -60, -47};
Plane Surface(64) = {63};
Line Loop(65) = {60, 55, 57, -48};
Plane Surface(66) = {65};
Line Loop(67) = {57, 49, -58, -56};
Plane Surface(68) = {67};

Transfinite Line {58, 57, 60, 59} = 2 Using Progression 1;
Transfinite Line {54, 53, 56, 55} = N + 1 Using Progression 1;
Transfinite Surface {66};
Transfinite Surface {64};
Transfinite Surface {62};
Transfinite Surface {68};
Recombine Surface {68, 62, 64, 66};

// Inlet
Extrude {0, 0, -L_in} {
  Surface{68, 52, 62, 64, 66, 43, 45, 39, 41, 22, 20, 18, 16, 14};
  Layers{n_in};
  Recombine;
}

// Outlet
Extrude {0, 0, L_out} {
  Surface{62, 52, 29, 14, 22, 16, 18, 20, 39, 41, 43, 45, 64, 66, 68};
  Layers{n_out};
  Recombine;
}

// Define volumes
Physical Volume(767) = {27, 25, 28, 26, 22, 21, 17, 18, 16, 19, 20, 24, 15, 23, 29, 4, 6, 5, 7, 11, 12, 2, 14, 10, 13, 9, 3, 8, 1};

// Define boundaries
Physical Surface(768) = {396, 330, 352, 374, 308}; // Nozzle in
Physical Surface(769) = {132, 220, 286, 264, 242, 198, 176, 154, 90}; // Coflow in
Physical Surface(770) = {418, 766, 744, 722, 460, 700, 678, 656, 634, 502, 568, 590, 612, 524, 546}; // Outlet
Physical Surface(771) = {713, 413, 765, 735, 167, 149, 89, 189, 29, 241, 255, 295, 321, 219, 277, 343, 361}; // Walls
