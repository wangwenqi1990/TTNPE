# TTNPE
This is the demo code for paper "Tensor Train Neighborhood Preserving Embedding"

Copyright @ Wenqi Wang, 2018
------------------------------------------------
To run the experiment Fig.3 and Fig.6 of the paper Tensor Train Neighborhood Preserving Embedding

(1) Data processing: download Weizmann Dataset from http://www.wisdom.weizmann.ac.il/~/vision/FaceBase/ and build a tensor named 'Data' with dimension 512 x 352 x 66 x 17, which represents 66 images of size 512 x 352 from 17 persons. Save it with name 'WeizmanData.mat' and put it in the folder Data_file.

(1) run demo.m for NPE algortihm comparision among KNN, TNPE and TTNPE

(2) The TTNPE-ATN is the implemented in the code Self_Tool/main_App.m. Please refer this function and the folder TT_Approximate for the detail implementation of the algorithm. 

-------------------------------------------------

Terms of use:

The code is provided for research purpose only without any warranty. Any commercial use if prohibited

When using the code, please cite the following paper:

Tensor Train Neighborhood Preserving Embedding
Wenqi Wang, Vaneet Aggarwal, and Shuchin Aeron
IEEE TRANSACTIONS ON SIGNAL PROCESSING, 2018, pp. 2724-2732

Available: https://ieeexplore.ieee.org/document/8319501/?arnumber=8319501&source=authoralert

--------------------------------------------------

Please contact Wenqi Wang (wang2041 [At] purdue [Dot] edu) for any questions about the code.
