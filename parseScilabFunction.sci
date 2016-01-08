//Created by: Krishna Shrestha
//E-mail: shresthakrishna1997@gmail.com

//This script defines a function 'parseScilabFunction', which accepts file name/path of '.sci' file as it's argument and returns all the Scilab functions and operators present in the specified file with their input arguments.

//To begin with, we will ask the user to enter the file name/path of the '.sci' file that may be opened. First thing that may be done is validate the file name/path accepted. While validating the file name/path, we will check two things, first that the file name/path has an extension '.sci' at its end, and second that the specified file exists.
function [output] = parseScilabFunction(path)
ext = strrchr(path, '.')            //This will store the extension, in other terms, the remaining part of the input string after the last occurence of character fullstop(.)
if (ext == ".sci") then
    fd = mopen(path, 'r')           //This will check whether the file exists. If yes, then it will open the file. 'fd' will store a number, which is zero when Scilab is unable to open the file. Otherwise, 'fd' will have a non-zero value.
    if (fd == 0) then
       error("Error: Cannot open file. ")        //Error message if the file name/path does not exist, or cannot be opened.
    end
    x = mfscanf(-1, fd, "%s")       //This will scan the whole of the file and store the content in string matrix 'x'.
    mclose(fd)                      //This will close the file opened by Scilab.
    l = length(x)
    col = length(l)                    //Here, we will get the total number of units storing content read from the specified file.
    counter = 0                  //'This will count number of operators present in the matrix 'x' (in other words, the file mentioned in the argument).
    output = []         //This matrix will hold the content that must be displayed in the output.
    for (n = 1 : 1 : col)           //Here, we scan every unit of matrix 'x' to check for the desired data
        for (n = 1 : 1 : col)
            p = l(n, 1)
            m = ["+", "-", "*", "/", "^"];
            l1 = getscilabkeywords();               //This will store the list of all Scilab keywords in 'l1'
            lf = getfield(4, l1);                   //This will assign the list of all Scilab functions (i.e. l1(4) ) to 'lf'
            if (p > 1) then
                //Break the cell and scan the contents within the cell
                q = x(n, 1)
                //First, we check for mathematical operators of Scilab. We will compare the contents of each of the cell of matrix 'x' with the mathematical operators. To do so, we will try to locate the mathematical operator symbol in the character string contained in the cell. If the operator does not exist, then strindex() will return a null value. If the operator symbol is found, then strindex() will return a non-zero value. In the second case, the arguments may be between "=" and operator, between operator and ";", after operator till the last character, or between two different operators. So, we may first try to locate all five mathematical operator, "=" sign and ";" sign.
                scounter = 0;               //Counter for position of an operator in the string
                len = length(q)             //This will give the length of string present in the particular cell of matrix 'x'.
                for (cc = 1 : 1 : len)       //Now, we will pick every single character and check for the presence of mathematical operators, "=" sign and ";".
                    a = part(q, cc)
                    com = [m, "=", ";"]
                    for (cm = 1 : 1 : 7)
                        b = com(1, cm)
                        r = ""
                        if (a == b) then        //Compare the two characters
                            if (b == "=") then      //If the character in the string matches with "=" sign, then the counter is increased by 1 and its position is noted.
                                scounter = scounter + 1;
                                posim(n, scounter) = cc;
                                continue
                            elseif (b == ";")           //If the character in the string is ";", then we will first check whether it is the first character in the string. If yes, we may simply move on to next cell. 
                                if (scounter == 0)
                                    break
                                end
                            else               //If the character in the string is some mathematical operator then counter is increased by 1, itsposition is noted and the each of two arguments is extracted from either in between any two symbols from matrix "com", or before the operator right from beginning of the string, or after the operation till the end of the string.
                                counter = counter + 1;
                                scounter = scounter + 1;
                                posim(n, scounter) = cc;
                                if (scounter - 1 == 0) then      //Here, 1st argument for the operator comprises of all the characters before the operator sign.
                                    ar1 = part(q, 1:cc-1);
                                else                        //Here, 1st argument for the operator comprises of all the characters start from the position next to previous sign to the positive just before the current operator sign.
                                    ccp = posim(n, scounter-1);
                                    ar1 = part(q, ccp+1:cc-1);
                                end
                                //The second argument to the mathematicaloperator will contain all the characters after the operator sign, till the end of the string excluding semicolon.
                                i = strindex(q, ";");       //This will locate ";" in the string. If ";" does not exist, then it will return a null matrix.
                                if (i == []) then               //We do this here in order to exclude ";"
                                    ar2 = part(q, cc+1:len)     
                                else
                                    ar2 = part(q, cc+1:i-1)
                                r = b + " " + ar1 + " " + ar2;           //The desired content for the output with proper formatting with be stored as 'r'
                                output(counter, 1) = r;                  //We pass the value of 'r' to output matrix.
                            end
                        end
                    end
                    
                   //Now we will check for the presence of any Scilab function in the string. For this, first try to locate "(", ")" and "=" and note their position. Then, we may extract and store as a separate string all the characters either between "=" and "(", or if "=" does not exist, then all characters before "(". If this string matches with any of the Scilab function name, then we may extract all the contents enclosed in brackets, i.e. the arguments of the Scilab function.
                    i1 = strindex(q, "=");
                    i2 = strindex(q, "(");
                    i3 = strindex(q, ")");
                    if (i2 == 0 | i3 == 0) then     //There cannot be a function without '(' and ')'
                        break
                    else
                        if (i1 == 0) then
                            fn = part(q, 1:i2-10);
                        else
                            fn = part(q, i1+1:i2-1);
                        end
                    end
                    for (cc = 1 : 1 : 2095)          //Searching the function in the list of Scilab functions
                        b = lf(cc, 1);
                        if (b == fn) then
                            ar = part(q, i2+1:i3-1);      //Extract the arguments enclosed in brackets
                            counter = counter + 1;
                            r = fn + " " + ar;              //The desired content for the output with proper formatting with be stored as 'r'
                            output(counter, 1) = r          //We pass the value of 'r' to output matrix.
                        end
                    end
                    
                end
                
            else
                //Check the content of the cell and note it's number. We may need the adjoining cells as well for our output. We will compare the contents of each cell with various operators and functions
                q = x(n, 1);
                //First, we check for mathematical operators of Scilab. We will compare the contents of each of the cell of matrix 'x' with the mathematical operators. If it does not match with any of the mathematical opertors, then we will try comparing it with each of the Scilab functions.
                
                for (a = 1 : 1 : 5);                     //Here, we start checking if the cell of matrix 'x' contains a mathematical operator.
                    b = m(1, a);
                    if (q == b) then
                        counter = counter + 1;              //The counter value will increase by 1 each time an operator is encountered.
                        r = b + " " + x(n-1) + " " + x(n+1)               //This will create a string that may be stored in the output matrix in desired format. All that is needed here is to remove ')' if it is at the end of the string
                        i = strindex(r, ";");      //This will give the location of semi-colon in the string 'r'. If semi-colon does not exist, it will return a null vector or null matrix.
                        if (i == []) then
                            nsc = r;
                        else
                            nsc = part(r, 1:i-1);  //This will pick up the characters present in the string from location 1 to the location just preceding the semi-colon. Thus, semi-colon is removed
                        end
                        output(counter, 1) = nsc;           //Store the string formatted for the output in output 
                        break;
                    end
                end
            for (a = 1 : 1 : 2095)     //Here, we start checking if the content of the cell is a Scilab function.
            b = lf(a, 1);
            if (q == b) then
                counter = counter + 1;
                nextCell = x(n+1, 1);          //Here, we pass the content of the cell next to Scilab function to 'nextCell'.
                if (nextCell == "(" | nextCell == "( ") then        //We will pick the arguments of the Scilab function. Here, the argument/s do not share cell with '('.
                else                        //This shall be the case when the argument/s share cell with '('.
                    c = length(nextCell);
                    t = nextCell(1, c);          //We find and locate the last character of the cell next to Scilab function.
                    if (t == ")" | t == " )")           //This shall be done if the last character in the said cell is ')'.
                        r = "(" + nextCell;                  //Doing this only in order to easily convert the content of 'nextCell' into a single string.
                        nsc = part(r, 3:c-1);            //Here, we extract the arguments of the Scilab function.
                        output(counter, 1) = nsc;
                    else                //In this case, at least one argument shares cell with '(', but ')' is in another cell. So, we will locate the position of the cell containing ')' and then join each character stored with the two characters, '(' and ')'.
                        for (ps = n+1 : 1 : col)
                            com = x(ps, 1)
                            if (com == ")") then
                                pos = ps
                                break
                            end
                        end
                        r = ""
                        for (co = n+1 : 1 : pos)
                            r = r + " " + x(co, 1)
                        end
                        i1 = strindex(r, "(");          //Position of '(' in string 'r'
                        i2 = strindex(r, ")");          //Position of ')' in string 'r'
                        nar = part(r, i1+1:i2-1);       //String containing the arguments of Scilab function
                        nsc = b + " " + nar;           //Joins the Scilab function name and its arguments in a string with punctuatuion.
                        output(counter, 1) = nsc;       
                    end
                    
                end
            end
        end
    end
end
end
else
    error("Error: The specified file must contain .sci extension")
end
endfunction



