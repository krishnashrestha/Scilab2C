//Creaed by: Krishna Shrestha
//E-mail: shresthakrishna1997@gmail.com

#include<stdio.h>
#include<coino.h>

//A simple program that functions similar to interp1()

double interp1(double x0, double y0, double x1, double y1, double x)
{
//Here we do the calculations for Linear Interpolation. We will pass only the first and last values from the vectors entered by the user to this function.

    double a, b, y;
    a = (y1 - y0) / (x1 - x0);
    b = -a * x0 + y0;
    y = a * x + b;
    return y;
}

void main()
{
    double x[100], y[100], xp, yp;
    int iSize, iLoop;

    clrscr();			//Clear the screen

    printf("Enter the number of elements for vectors x and y: ");
    scanf("%d", iSize);

    printf("\nEnter x: ");
    for (iLoop = 0; iLoop < iSize; iLoop++)
        scanf("%f", &x[iLoop]);

    printf("\nEnter y: ");
    for (iLoop = 0; iLoop < iSize; iLoop++)
        scanf("%f", &y[iLoop]);

    printf("\nEnter xp: ");
    scanf("%d", &xp);
    
    interp1(x[0], y[0], x[iSize-1], y[iSize-1], xp)
    getch();
}

