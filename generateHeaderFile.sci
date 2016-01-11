//This will create a C header file for the function whose name, return type and arguments are accepted as arguments by function generateHeaderFile()

//We begin with defining a function 'generateHeaderFile', which will accept three arguments, i.e. functName, arguments, returnType. This function will write a C header file for the function whose details are mentioned as the arguments to function 'generateHeaderFile'. functName will be the name of required function, arguments will store its arguments and returnType will store its return type.

function generateHeaderFile(functName, arguments, returnType)
    
    l = size(arguments)                     //Here, we measure the size of the matrix 'arguments'. size(arguments) will return the number of rows and columns in the matrix 'arguments'. This value is stored in a row matrix 'l'. The matrix 'l' will always comprise of a single row and two columns. The number stored in 1st row and 1st column determines the number of rows in the matrix 'arguments', whereas the 1st row and 2nd column value will tell us how many columns are present in matrix 'arguments'.
    
    i = l(1, 2)                             //We extract the value stored in 1st row and 2nd column of matrix 'l' and store it in a variable 'i'. This value is the number of input variable names and their respective data types, which will be the arguments for the required function in the header file.
    
    l = 0
//The previous contents of l are no more reqired. So, we replace them with zero. Now, we will use l as a counter for the number of data types present in the matrix 'arguments'. After this, the contents of the matrix 'arguments' will be scanned for data types. For this, we will use the for looping structure, where the variable 'n' is the column number, starting from 1. We will pick the contents of each cell of the matrix 'arguments', one at a time, and check if it is a data type. With starting value as zero, each time a cell in the matrix 'arguments' contains a data type, the value of l will be increased by 1. This data type value will be stored in a cell of another matrix 'a', where coulumn number is given by the counter variable 'l'. The data types keywords which may be acknowledged are int, float, char, long int, int *, char *, uint8.
    for (n = 1 : 1 : i)
        m = arguments(1,n)
        disp(m)
        if (m == "uint8") then
            l = l + 1
            a(1, l) = "int"             //If, user enters 'uint8', then it will pass the keyword 'int' to the matrix 'a'. Rest of the data type keywords, including 'int', will be passed tomatrix 'a' with no change.
            continue
        elseif (m == "float" | m == "char" | m == "char *" | m == "long int" | m == "int *" | m == "int" ) then
            l = l + 1
            a(1, l) = m
            continue
        else 
            continue
        end
    end

//After extracting all the data types from the argument, we will place all text required in our header file together in a single string. For that, we will first join all the data types in order with each other and all add commas wherever required. To do so, we will call a string 's' whose initial value will be equal to the first data type obtained in the matrix 'arguments' or rather say the content of the first cell of matrix 'a'. With the help of for looping structure, we will join all the elements of the matrix 'a', and also put comma and blank space each time the content of next cell of matrix 'a' is added to the string. The value of counter variable 'n' starting from 2, will increase by 1 each time the loop executes, and the loop will execute till the value of 'n' becomes equal to the value of our data type counter 'l'.
    s = a(1, 1)
    for ( n = 2 : 1 : l)
        s = s + "," + " " + a(1, n)
    end

//After completing the task of joining all the arguments of output function prototype along with punctuating them, we will now place the function name, it's return type and the arguments in proper order.
    p = returnType + " " + functName + "(" + s + ")"

//Now, the function prototype is ready to be written in header file. mputl() will create a C header file for the required function in the current working directory of the Scilab, and write the contents of string 'p' i.e. the function prototype in the file.
    mputl(p, functName+".h")

endfunction
