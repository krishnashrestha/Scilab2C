//Created by: Krishna Shrestha
//E-mail: shresthakrishna1997@gmail.com

//This is a programthat works similar to dsearch() function.

#include<stdio.h>
#include<conio.h>

void dsearch(int **, int *, char);

void main()
{
    int i, j, row, col, x[50][50];
    int nb, bins[100];
    char pm;
    
    clrscr();
    
    printf("Enter no of rows and columns of the matrix : ");
    scanf("%d %d", &row, &col);
    
    printf("Enter the matrix: ");
    for(i=0; i<r; i++)
    {
	for(j=0; j<c; j++)
	    scanf("%d", &x[i][j]);		//Accept the contents for the matrix
    }
    
    printf("Enter the number of bins: ");
    scanf("%d", &nb);
    
    printf("bins = ");
    for(i=0; i<nb; i++)
	scanf("%d", &bins[i]);			//Accept the contents for bins
    
    printf("Enter the mode: ");
    scanf("%c", &pm);
    
    dsearch(x, bins, pm);
    getch();
}

void dsearch(int x[50][50], int bins[100], char pm)
{
    int i, j, k;
    int i_bin[50][50], count[]={0}, outside=0;
    switch (pm)
    {
	case 'd':
	    for(k=0; k<100; k++)
	    {
		for(i=0; i<50; i++)
		{
		    for(j=0; j<50; j++)
		    {
			if( x[i][j] == bins[k] )
			{
			    i_bin[i][j] = k;
			    count[k]++;
			}
			else
			{
			    i_bin[i][j]=0;
			    outside++;
			}
		    }
		}
	    }
  	case 'c' :
	    int a, b;
	    for(k=0; k<100; k++)
	    {
		a = bins[k];
		b = bins[k+1];
		for(i=0; i<50; i++)
		{
		    for(j=0; j<50; j++)
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
	default :
	    printf("Please enter a valid choice");
    }
    printf("\n\ni_bin =");
    for(i=0; i<50; i++)
    {
	printf("\n");
	for(j=0; j<50; j++)
	    printf("%d\t", x[i][j]);
    }
    printf("\n\nOccurence =");
    for(i=0; i<100; i++)
    printf("%d\t", count[i]);
    printf("\n\nOutside = %d", outside);
}
