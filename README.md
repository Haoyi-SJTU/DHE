# DHE

![MATLAB Version](https://img.shields.io/badge/MATLAB-R2023a%2B-orange)
![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)

## 1. Overall Structure
This folder (`DHE/`) contains MATLAB code, configuration files, and data files related to robotics (or dynamic analysis). The subfolder `sample_data/` stores sample data and configurations. The `.m` files in the root directory can be categorized by function into **main programs, kinematics calculation, velocity optimization, Hessian matrix processing, visualization, area calculation, auxiliary tools**, etc. The detailed structure and file functions are described below:

```
DHE/
│
├── main.m
├── SHE.m
├── draw_SHE.m
├── single_q_velocity_gurobi.m
├── q_velocity_gurobi.m
├── EHE.m
├── single_q_velocity_new.m
├── forward_kinematics_alpha.m
├── forward_kinematics_beta.m
├── draw_save_DHEbar.m
├── draw_save_EHEbar.m
├── draw_EHE.m
├── cal_SHE_areas.m
├── cal_EHE_areas.m
├── read_q_file.m
├── kernal_process.m
├── Jacobian.m
├── forward_kinematics.m
├── hessian_hrr.m
├── matrixplot.m
├── EllipseVertices.m
├── parseInputs.m
├── SquareVertices.m
├── parseArgs.m
├── MyPatch.m
├── draw_save_EHE.m
├── hessian_rotate_down.m
├── hessian_trans_down.m
├── hessian_trans_up.m
├── hessian_rotate_up.m
├── Jacobian_translation.m
├── Jacobian_rotate.m
├── draw_EHEbar.m
├── sample_data/
│   ├── color_list.mat
│   ├── hrr_config.mat
│   └── sample_jointdata.txt
```

### 1.1 Main Program and Entry
- `main.m`: The main entry script for the project, likely used to call other modules to perform end-to-end analysis.

### 1.2 Specific Metrics (SHE/EHE) Related
- `EHE.m`: Implements the calculation logic for EHE.
- `SHE.m`: Implements the calculation logic for SHE.

### 1.3 Kinematics-Related
- `forward_kinematics.m`: Forward kinematics calculation (joint angles → end-effector pose).
- `forward_kinematics_alpha.m` / `forward_kinematics_beta.m`: Subdivided versions of forward kinematics (possibly corresponding to different coordinate systems or joint groups).

### 1.4 Velocity Optimization (Gurobi Solver)
- `single_q_velocity_gurobi.m`: Single-joint velocity optimization (based on the Gurobi solver).
- `q_velocity_gurobi.m`: Multi-joint velocity optimization (based on the Gurobi solver).
- `single_q_velocity_no_gurobi.m`: Single-joint velocity optimization (non-Gurobi implementation).

### 1.5 Hessian Matrix Processing
- `hessian_hrr.m`: Hessian matrix calculation (likely related to the "HRR" algorithm).
- `hessian_rotate_up.m` / `hessian_rotate_down.m`: Hessian matrix rotational transformation (upward/downward).
- `hessian_trans_up.m` / `hessian_trans_down.m`: Hessian matrix translational transformation (upward/downward).

### 1.6 Visualization Tools
- `draw_EHE.m`: Visualizes EHE results.
- `draw_SHE.m`: Visualizes SHE results.
- `draw_EHEbar.m`: Draws bar charts/histograms for EHE.
- `draw_save_DHEbar.m`: Draws and saves bar charts for DHE.
- `draw_save_EHEbar.m`: Draws and saves bar charts for EHE.
- `draw_save_EHE.m`: Draws and saves EHE visualization results.

### 1.7 Area Calculation
- `cal_SHE_areas.m`: Calculates areas related to SHE.
- `cal_EHE_areas.m`: Calculates areas related to EHE.

### 1.8 Auxiliary Tools
- `read_q_file.m`: Reads joint angle (`q`) data files.
- `kernal_process.m`: Core processing function (possibly for data processing or algorithm core).
- `Jacobian.m`: Jacobian matrix calculation (kinematic differential relationship).
- `Jacobian_translation.m` / `Jacobian_rotate.m`: Translational/rotational components of the Jacobian matrix.
- `matrixplot.m`: Matrix visualization.
- `EllipseVertices.m` / `SquareVertices.m`: Auxiliary functions for matrixplot. Computes vertices of ellipses/squares (for plotting).
- `parseInputs.m` / `parseArgs.m`: Auxiliary functions for matrixplot. Parses input parameters (command line or function arguments).
- `MyPatch.m`: Auxiliary function for matrixplot. Custom patch drawing.

### 1.9 Subfolder: `sample_data/`
`sample_data/` stores sample data and configuration files for testing or demonstrating code functionality:

- `color_list.mat`: A MATLAB data file containing a color list for visualization color schemes.
- `hrr_config.mat`: Configuration file for HRR.
- `sample_jointdata.txt`: Sample joint angle data (text format, for reading by functions like `read_q_file.m`).

## 2. Requirements
- **RAM**: > 8 GB
- **Required Software**:
  - MATLAB: Version >= R2023a
  - Gurobi Optimizer
- **Required Toolboxes**:
  - MATLAB Robotics Toolbox

  
## 3. Usage
1. Run `main.m` as the entry point to observe the overall workflow.
2. For test data, read from `sample_data/` (e.g., `read_q_file.m` can read `sample_jointdata.txt`).
3. Visualization functions (e.g., `draw_*.m`) will generate graphs, which can be analyzed in combination with area calculation functions (`cal_*.m`).
