package algorithm;

public class AlgorithmWithCharAt {

	public static void main (String[] args) { //main method
		
    	//Binary Number
        String binaryNumber = "1010"; //declare and initialize binaryNumber
        
        
        //Decimal Number
        int decimalNumber = binaryToDecimal(binaryNumber); //declare and initialize (by going into the method) decimalNumber
        
        //Check if the binary number is valid or not
        if(decimalNumber == -1)
        {
        	System.out.println("Invalid Binary Number!");
        	return;
        }
        
        //print binaryNumber and decimalNumber
        System.out.println("Binary Number: " + binaryNumber); 
	    System.out.println("Decimal Number: " + decimalNumber); 
	    
	    
	    //Digital Number
	    System.out.println("Digital Number: ");
	    printDigitalNumber(decimalNumber); //print digital number
	    
    } //end of main method
    
    static public int pow(int base, int power) //pow method
    {
        int result = 1; //declare and initialize  result
        
        //iterate to calculate the result
        for (int i = 0; i < power; i++) 
        {
            result *= base; //calculate the result
        }
        return result; //return the result
    } //end of pow method
    
    static public int binaryToDecimal(String binaryNumber) //binaryToDecimal method
    {
    	int decimalNumber = 0; //declare and initialize decimalNumber
    	
    	//iterate to calculate the decimalNumber and check if the binaryNumber is valid
    	for(int r = 0; r < binaryNumber.length(); r++)
	    {
    		//calculate decimalNumber
    		if(binaryNumber.charAt(r) == '1')
    		{
    			decimalNumber += pow(2, (binaryNumber.length() - r - 1));
    		}
    		
    		//check if binary number is valid
    		else if(binaryNumber.charAt(r) != '0')
    		{
    			return -1; //return -1
    		}
	    }
    	
    	return decimalNumber; //return decimal number
    } //end of binaryToDecimal method
    
    static public int calculateNumOfDigits(int decimalNumber) //calculateNumOfDigits method
    {
        int numOfDigits = 0; //declare and initialize numOfDigits
        
        //calculate numOfDigits
        if(decimalNumber == 0)
        {
            numOfDigits = 1;
        }
        
      //calculate numOfDigits
        else
        {
	        while(decimalNumber != 0)
	        {
	            decimalNumber = decimalNumber/10;
	            numOfDigits++;
	        }
        }
        
    	return numOfDigits; //return numOfDigits
    } //end of calculateNumOfDigits method
    
    static public void printDigitalNumber(int decimalNumber) //printDigitalNumber method
    {
    	int num[][] = {{1, 1, 0, 1, 1, 1, 1}, 
    				   {0, 0, 0, 1, 0, 0, 1}, 
    				   {1, 0, 1, 1, 1, 1, 0}, 
    				   {1, 0, 1, 1, 0, 1, 1}, 
    				   {0, 1, 1, 1, 0, 0, 1}, 
    				   {1, 1, 1, 0, 0, 1, 1}, 
    				   {1, 1, 1, 0, 1, 1, 1}, 
    				   {1, 0, 0, 1, 0, 0, 1},
    				   {1, 1, 1, 1, 1, 1, 1}, 
    				   {1, 1, 1, 1, 0, 0, 1}}; //declare and initialize num (two-dimensional array of type int)
    	
    	int numOfDigits = calculateNumOfDigits(decimalNumber); //callback to numOfDigits method
    	
    	//iterate to print the 3 lines
        for(int i = 0; i < 3; i++) 
        {
        	//iterate to print every digit in each line
            for(int j = 0; j < numOfDigits; j++)
            {
            	
            	int digit = (decimalNumber/pow(10, numOfDigits - 1 - j))%10; //declare and initialize digit
            	
            	//print the first line
            	if(i == 0)
            	{
            		if(num[digit][0] == 1)
                    {
                    	System.out.print(" _ ");
                    }
                    else
                    {
                    	System.out.print("   ");
                    }
            	}
            	
            	//print the second line
            	else if(i == 1)
            	{
            		for(int k = 1; k < 4; k++)
                	{ 
            	        if(num[digit][k] == 1)
            	        {
            	        	if(k == 2)
            	        	{
            	        		System.out.print("_");
            	        	}
            	        	else
            	        	{
            	        		System.out.print("|");
            	        	}
            	        }
            	        else
            	        {
            	        	System.out.print(" ");
            	        }
                	}
            	}
            	
            	//print the third line
            	else if(i == 2)
            	{
            		for(int k = 4; k < 7; k++)
                	{
            	        if(num[digit][k] == 1)
            	        {
            	        	if(k == 5)
            	        	{
            	        		System.out.print("_");
            	        	}
            	        	else
            	        	{
            	        		System.out.print("|");
            	        	}
            	        }
            	        else
            	        {
            	        	System.out.print(" ");
            	        }
                	}
            	}
            	
            } 
            
            System.out.println("");
        }
    } //end of printDigitalNumber method

} 
