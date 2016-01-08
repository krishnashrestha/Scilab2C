# Scilab2C
Contains the codes for Section-A for Scilab2C Toolbox FOSSEE Internship

In this repository, you will find 4 files other than this readme. Those are :

1. generateHeaderFile.sci
This will create a C header file for the function whose name, return type and arguments are accepted as arguments by function generateHeaderFile(). 
After executing the file generateHeaderFile.sci in Scilab, you may either assign values to the three mentioned arguments in the code and then call generateHeaderFile() function or directly call the function with the desired arguments.

2. parseScilabFunction.sci
This script defines a function 'parseScilabFunction', which accepts file name/path of '.sci' file as it's argument and returns all the Scilab functions and operators present in the specified file with their input arguments.
After executing the file parseScilabFunction.sci in Scilab, you may either assign file name/path to a variable and then call parseScilabFunction() function with the variable name or directly call the function with the desired path/file name.

The function is capable of working with most of the types of '.sci' files, irrespective of whether blank spaces are given in between the statements or no.

3. interp1.c
A simple program that functions similar to interp1(). Here, after executing the file using C compiler, you may enter the number of elements in vectors x and y, assign data to the two vectors and enter the value of xp. Using the algorithm for Simple Interpolation method, the function interp1() will calculate the value of yp.

4. dsearch.c
This is a program that functions similar to dsearch() function of Scilab. Here, after executing the file using C compiler, you may first determine the number of cells in the matrix 'x' and also for matrix 'bins', and assign data to the matrices. After this, you may choose one among the two modes, continuous and discrete. 
