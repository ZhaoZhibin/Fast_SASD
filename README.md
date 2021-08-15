# Fast_SASD
Source codes for the paper "Fast Sparsity-Assisted Signal Decomposition with Non-Convex Enhancement for Bearing Fault Diagnosis"



This repository contains the implementation details of our paper: [IEEE/ASME Transactions on Mechatronics]
"[**Fast Sparsity-Assisted Signal Decomposition with Non-Convex Enhancement for Bearing Fault Diagnosis**](https://ieeexplore.ieee.org/document/9512403/)" 
by [Zhibin Zhao](https://zhaozhibin.github.io/). 


## About
Sparsity-assisted signal decomposition based on morphological component analysis (MCA) for bearing fault diagnosis has been studied in depth. However, existing algorithms often use different combinations of representation dictionaries and priors, leading to difficult dictionary choice and high computational complexity. This paper aims to develop a fast sparsity-assisted algorithm to decompose a vibration signal into discrete frequency and impulse components for bearing fault diagnosis. We introduce the morphological discrimination of discrete frequency and impulse components in time and frequency domains respectively for the first time. To use this morphological discrimination, we establish a fast sparsity-assisted signal decomposition (SASD) based on MCA with non-convex enhancement. We further prove the necessary and sufficient condition to guarantee the convexity and use the majorization minimization (MM) algorithm to derive a fast solver. The proposed algorithm not only has low computational complexity, but also avoids choosing multiple dictionaries as well as underestimation of impulse features. Furthermore, an adaptive parameter selection algorithm to set parameters of our algorithm is designed for real applications. The effectiveness of fast SASD and its adaptive variant is verified by both simulation studies and bearing diagnosis cases.

## Dependencies


## Pakages

This repository is organized as:
- [Fun](https://github.com/ZhaoZhibin/Fast_SASD/tree/master/Fun) contains the main functions of the algorithm.
- [utils](https://github.com/ZhaoZhibin/Fast_SASD/tree/master/utils) contains the extra functions of the test.
- [Data](https://github.com/ZhaoZhibin/Fast_SASD/tree/master/Data) contains the simulation and experiment verification of the proposed algorithm.
- [Figures](https://github.com/ZhaoZhibin/Fast_SASD/tree/master/Figures) contains the results of the algorithm.
- [Plot](https://github.com/ZhaoZhibin/Fast_SASD/tree/master/Plot) contains the Plot functions.


Main functions:
- [Plot_Simulation_Signal.m] plot the simulated signal with periodic impulses, discrete frequency components, and Gaussian noise.
- [Plot_Simulation_SASD.m] performs signal decomposition of the simulated signal.
- [Plot_CWRU_Rolling_118.m] plots the signals measured from a fault bearing from CWRU 118.mat.
- [Plot_CWRU_Rolling_118_SASD.m] performs feature extraction of a fault bearing from CWRU 118.mat.
- [Plot_CWRU_Normal_0_1797.m] plots the signals measured from a normal bearing from CWRU.
- [Plot_CWRU_Normal_0_1797_SASD.m] performs feature extraction of a normal bearing from CWRU.



## Implementation:
Flow the steps presented below:
-  Clone this repository.
```
git clone https://github.com/ZhaoZhibin/Fast_SASD.git
open it with matlab
```
-  Test Simulation: Run `Plot_Simulation_SASD.m`. 
-  Test fault diagnosis of a fault bearing: Run `Plot_CWRU_Rolling_118_SASD.m`. 
-  Test fault diagnosis of a normal bearing: Run `Plot_CWRU_Normal_0_1797_SASD.m`. 


## Citation
If you feel our Fast_SASD is useful for your research, please consider citing our paper: 

```
@article{zhao2021Fast,
  title={Fast Sparsity-Assisted Signal Decomposition with Non-Convex Enhancement for Bearing Fault Diagnosis},
  author={Zhao, Zhibin and Wang, Shibin and Wong, David and Wang, Wendong and Ruqiang, Yan and Chen, Xuefeng},
  journal={IEEE/ASME Transactions on Mechatronics},
  year={2020},
  publisher={IEEE}
}
```
## Contact
- zhibinzhao1993@gmail.com

