# DHE

![MATLAB Version](https://img.shields.io/badge/MATLAB-R2023a%2B-orange)
![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)


A MATLAB toolbox for evaluating the **disturbance resistance** of hyper-redundant robots (HRRs) using a novel geometric metric — the **Disturbance Hyper-Ellipsoid**.

## Overview

Hyper-redundant robots (e.g., snake-like manipulators with 24+ DOF) exhibit varying resistance to external disturbances across different joint configurations. This project quantifies that resistance by projecting the high-dimensional disturbance mapping onto 2D joint subspaces, producing intuitive **ellipse visualizations** whose shape, orientation, and area reveal each joint pair's vulnerability.

The default configuration is a **24-DOF snake robot** with **12 universal joints**, each consisting of an (α, β) rotation pair. The kinematic chain is:

```
T_total = T_α₁ · T_β₁ · T_α₂ · T_β₂ · … · T_α₁₂ · T_β₁₂
```

Robot geometry parameters (`L`, `h1`, `h2`) are loaded from `sample_data/hrr_config.mat`.

Three levels of fidelity are provided:

| Metric | Description | Dependency |
|--------|-------------|------------|
| **EHE** | Ellipsoidal Hyper-Ellipsoid — first-order (Jacobian-based) | MATLAB + Symbolic Math Toolbox |
| **SHE** | Second-order Hyper-Ellipsoid — incorporates Hessian curvature | + Gurobi Optimizer |
| **DHE** | Dynamic Hyper-Ellipsoid — includes joint velocity effects | + Gurobi Optimizer |


If you use this code, please cite our paper:

```
@ARTICLE{,
  author={Haoyi Song, Zhenpu Zhu, Zhanxuan Peng, Weichao Guo, Chao Liu, Yangmin Li and Xinjun Sheng},
  journal={International Journal of Control, Automation and Systems}, 
  title={Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance Resistance of Hyper-redundant Robots}, 
  year={2026},
  volume={},
  pages={},
  keywords={},
  doi={}}

```
Video for experiments: [Video Demonstration](https://youtu.be/LZfitKhQ1Bw)


## Structure
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

### Main Program and Entry
- `main.m`: The main entry script for the project, likely used to call other modules to perform end-to-end analysis.

### Specific Metrics (SHE/EHE) Related
- `EHE.m`: Implements the calculation logic for EHE.
- `SHE.m`: Implements the calculation logic for SHE.

### Kinematics-Related
- `forward_kinematics.m`: Forward kinematics calculation (joint angles → end-effector pose).
- `forward_kinematics_alpha.m` / `forward_kinematics_beta.m`: Subdivided versions of forward kinematics (possibly corresponding to different coordinate systems or joint groups).

### Velocity Optimization (Gurobi Solver)
- `single_q_velocity_gurobi.m`: Single-joint velocity optimization (based on the Gurobi solver).
- `q_velocity_gurobi.m`: Multi-joint velocity optimization (based on the Gurobi solver).
- `single_q_velocity_no_gurobi.m`: Single-joint velocity optimization (non-Gurobi implementation).

### Hessian Matrix Processing
- `hessian_hrr.m`: Hessian matrix calculation (likely related to the "HRR" algorithm).
- `hessian_rotate_up.m` / `hessian_rotate_down.m`: Hessian matrix rotational transformation (upward/downward).
- `hessian_trans_up.m` / `hessian_trans_down.m`: Hessian matrix translational transformation (upward/downward).

### Visualization Tools
- `draw_EHE.m`: Visualizes EHE results.
- `draw_SHE.m`: Visualizes SHE results.
- `draw_EHEbar.m`: Draws bar charts/histograms for EHE.
- `draw_save_DHEbar.m`: Draws and saves bar charts for DHE.
- `draw_save_EHEbar.m`: Draws and saves bar charts for EHE.
- `draw_save_EHE.m`: Draws and saves EHE visualization results.

### Area Calculation
- `cal_SHE_areas.m`: Calculates areas related to SHE.
- `cal_EHE_areas.m`: Calculates areas related to EHE.

### Auxiliary Tools
- `read_q_file.m`: Reads joint angle (`q`) data files.
- `kernal_process.m`: Core processing function (possibly for data processing or algorithm core).
- `Jacobian.m`: Jacobian matrix calculation (kinematic differential relationship).
- `Jacobian_translation.m` / `Jacobian_rotate.m`: Translational/rotational components of the Jacobian matrix.
- `matrixplot.m`: Matrix visualization.
- `EllipseVertices.m` / `SquareVertices.m`: Auxiliary functions for matrixplot. Computes vertices of ellipses/squares (for plotting).
- `parseInputs.m` / `parseArgs.m`: Auxiliary functions for matrixplot. Parses input parameters (command line or function arguments).
- `MyPatch.m`: Auxiliary function for matrixplot. Custom patch drawing.

### Subfolder: `sample_data/`
`sample_data/` stores sample data and configuration files for testing or demonstrating code functionality:

- `color_list.mat`: A MATLAB data file containing a color list for visualization color schemes.
- `hrr_config.mat`: Configuration file for HRR.
- `sample_jointdata.txt`: Sample joint angle data (text format, for reading by functions like `read_q_file.m`).

## Requirements
- **RAM**: > 8 GB
- **Required Software**:
  - MATLAB: Version >= R2023a
  - Gurobi Optimizer
- **Required Toolboxes**:
  - MATLAB Robotics Toolbox

  
## Usage
1. Run `main.m` as the entry point to observe the overall workflow.
```matlab
    % Run the full demo (EHE → SHE)
    main
```

2. For test data, read from `sample_data/` (e.g., `read_q_file.m` can read `sample_jointdata.txt`).
3. Visualization functions (e.g., `draw_*.m`) will generate graphs, which can be analyzed in combination with area calculation functions (`cal_*.m`).


## Output Examples

| Visualization | Function | Format |
|---|---|---|
| Animated projection ellipses | `draw_EHE`, `draw_SHE` | MATLAB figure |
| Area bar charts | `draw_EHEbar` | MATLAB figure |
| Time-series heatmap | `matrixplot` | MATLAB figure |
| Saved animations | `draw_save_EHE`, `draw_save_EHEbar`, `draw_save_DHEbar` | `.avi` video |
| Kernel conditioning analysis | `kernal_process` | 10-panel figure |


## License

[BSD 3-Clause "New" or "Revised" License](https://github.com/Haoyi-SJTU/DHE/blob/main/LICENSE)
