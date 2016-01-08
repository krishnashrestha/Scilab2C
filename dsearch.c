//Created by: Krishna Shrestha

//This is a program that functions similar to dsearch() function of Scilab.

#include<stdio.h>
#include<conio.h>
int row, col, nb;
int i, j, k;
int pm;
int x[50][50]={0}, bin[100]={0}, i_bin[50][50]={0}, count[100]={0}, out=0;
void discrete();
void continuous();
void mode();
void result();
void main()
{
    clrscr();
    printf("Enter the number of rows and colums of the matrix: ");
    scanf("%d %d", &row, &col);
    printf("\n\nEnter the matrix: ");
    for(i=0; i<row; i++)
    {
	for(j=0; j<col; j++)
	    scanf("%d", x[i][j]);
    }
    printf("\n\nEnter no of bins: ");
    scanf("%d", &nb);
    printf("\n\nEnter bin: ");
    for(k=0; k<nb; k++)
	scanf("%d", bin[k]);
    printf("\n\nEnter mode (0 for Continuous and 1 for Discrete): ");
    scanf("%d", &pm);
    mode();
    getch();
}
void mode()
{
    switch(pm)
    {
	case 0 : default :
	    continuous();
	    break;
	case 1:
	    discrete();
	    break;
    }
}
void discrete()
{
    clrscr();
    for(k=0; k<nb; k++)
    {
	for(i=0; i<row; i++)
	{
	    for(j=0; j<col; j++)
	    {
		if(x[i][j] == bin[k])
		{
		    i_bin[i][j] = x[i][j];
		    count[k]++;
		}
		else
		    out++;
	    }
	}
    }
    result();
}
void continuous()
{
    int a, b;
    for(k=0; k<nb; k++)
    {
	a = bin[k];
	b = bin[k+1];
	for(i=0; i<row; i++)
	{
	    for(j=0; j<col; j++)
	    {
		if(a == x[i][j])
		{
		    if(k==0 || k==1)
			i_bin[i][j] = 1;
		    else
			i_bin[i][j] = k-1;
		}
		else if(a < x[i][j])
		{
		    while(a<=b)
		    {
			a++;
			if(a == x[i][j])
			    i_bin[i][j] = k+1;
		    }
		}
		else
		{
		    i_bin[i][j] = 0;
		    out++;
		}
	    }
	}
    }
    result();
}
void result()
{
    printf("i_bin = ");
    for(i=0; i<row; i++)
    {
	printf("\n");
	for(j=0; j<col; j++)
	    printf("%d\t", i_bin[i][j]);
    }
    printf("\n\ncounts = \n");
    for(k=0; k<nb; k++)
	printf("%d\t", count[k]);
    printf("\n\nOutside = \n%d", out);
}
