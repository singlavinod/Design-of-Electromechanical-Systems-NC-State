## Design-of-Electromechanical-Systems-Spring17-Project

This repository contains project report and supporting code submitted in spring 17 for meeting the requirements of MAE 535: Design of Electromechanical Systems course taken under Dr. Gregory Buckner at NC State University.

### Project Description
The primary objective of this project was to apply the modeling, analysis, and design principles of MAE 535: Design of Electromechanical Systems course to optimize the design of a semi-active haptic feedback device to produce controllable, high- amplitude damping forces with minimal size, weight, and electrical input power. Specifically, the task was to design and simulate a device that met or exceeded the following  design specifications:

1. An “on state” damping force of at least 40 N at a velocity of 1 m/s (more is better, but not more than 120 N) using a 12V, 1A power source (less required electrical power is better).
1. An “off state” damping force of not more than 5 N at a velocity of 1 m/s (less is better)
1. An electrical (LR) time constant of less than 100 ms (0.1 seconds)
1. Featured the smallest possible size and weight

The following design parameters were fixed:
1. The spool and cylinder were made of iron.
1. All other components were non-ferromagnetic (aluminum, plastic, rubber, etc.).
1. The MR fluid for this design was Lord Corporation’s MRX-336AG.
1. The coil was wound using 30-gage copper magnet wire.
1. The fluid gap was 1.0 mm or more.
1. The central through hole was 1.0 mm.

*A more detailed discussion about the techniques used can be found in 'Project_Report_Final.pdf' file in this repository.*

*My role in the project was performing design optimization using genetic algorithm, running a 2D simulation of the magnetic circuit (FEMM) and preparing the project report.*

*Current students: please avoid plagiarizing this code as it is in violation of the NC state academic code of conduct.*
