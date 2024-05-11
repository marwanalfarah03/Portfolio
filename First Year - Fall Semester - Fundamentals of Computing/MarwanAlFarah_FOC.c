#include <stdio.h>
#include <string.h>	/*to use the strlen function in the hangman game */
#include <stdlib.h>	/*to use the random function in the hangman game */
#include <time.h>	/*to use the random function in the hangman game */
#include "foc_fa22.h"	/*to display the image of the trials in guess the number game */
void startGuessTheNumberGame (); /*startGuessTheNumberGame function*/
void startHangmanGame (); /*startHangmanGame function*/
int main ()
{
  int q = 0;                   /*while statement condition*/
  int a;			/*switch statement argument*/
  char name[30];		/*player's name*/
  printf ("Please Enter Your Name : ");	/*to enter the name */
  scanf ("%s", name);	/*to enter the name */
  printf ("Welcome %s!\n", name); /*display welcome message and name */
  do	/*beginning of do while loop */
    {
      printf("Please enter the number of the game you wish to play, or choose Exit.\n");
      printf ("1. Guess the Number.\n");
      printf ("2. Hangman.\n");
      printf ("3. Exit\n");
      scanf ("%d", &a);		/*to choose from the menu */
      switch (a)		/*beginning of switch statement */
	{case 1:		/*beginning of case 1 in switch statement */
	  {startGuessTheNumberGame ();} /*callback to the startGuessTheNumberGame function*/
	  break;		/*end of case 1 in switch statement */
	case 2:		/*beginning of case 2 in switch statement */
	  {startHangmanGame ();} /*callback to the startHangmanGame function*/
	  break;		/*end of case 2 in switch statement */
	case 3:		/*beginning of case 3 in switch statement */
	  {q = 1;}		/*to exit the do while loop */
	  break;		/*end of case 3 in switch statement */
	default:	/*beginning of default case in switch statement*/
	  {printf ("Invalid choice.\n");} /*end of default case in switch statement*/
	}			/*end of switch statement */
    }while (q != 1);		/*end of do while loop */
  return 0;}			/*end of main function */



void startGuessTheNumberGame () /*beginning of startGuessTheNumberGame function */
{
  int secnum;		/*secret number */
  int trial = 0;	/*number of trial with a starting value of 0 */
  int mid;	/*the mid value between the low value and high value */
  int low = 1;		/*the low value with a starting value of 1 */
  int high = 10000;	/*the high value with a starting value of 10000 */
  int u = 0;	/*the while loop's condition with a starting value of 0 */
  int b;		/*switch statement argument */
  int x[150][150];     /*the image's array that consists of 150 rows and 150 columns */
  int i = 0;	       /*the number of the row in the image(array) */
  int j = 0;	/*the number of the column in the image(array) */
  printf ("Guess the Number has started.\n");
  do /*beginning of do while loop */
    {
      printf ("Enter a secret number between 1 and 10000: "); /*to enter the secret number */
      scanf ("%d", &secnum);	/*to enter the secret number */
      if (secnum < 1 || secnum > 10000) /*beginning of if statement, and it enters it if the entered secret number isn't in the range between 1 and 10000 */
	{printf ("Invalid choice.\n");}	/*end of if statement */
    }while (secnum < 1 || secnum > 10000);	/*end of do while loop */


  while (u != 1)	/*beginning of while loop, that doesn't exit until the user enters choice 1 in the switch statement */
    {
      mid = (low + high) / 2;	/*to calculate the mid value between the low value and high value */
      printf ("My guess is: %d\n", mid);	/*display the mid value */
      printf ("Please choose one of the following 3 options:\n");
      printf ("1. My guess is correct.\n");
      printf ("2. The secret number is larger than %d\n", mid);
      printf ("3. The secret number is smaller than %d\n", mid);
      scanf ("%d", &b);		/*to enter your choice in variable b */
      switch (b)
	{			/*beginning of switch statement */
	case 1:
	  {			/*beginning of case 1 in switch statement */
	    u = 1;		/*to exit the while loop */
	    trial++;		/*to increase the trial counter by 1 */
	    printf("It took me %d tries to find the secret number.\n", trial); /*to diplay the number of tries*/
	    for (i = 0; i < 150; i++)	/*counter for the rows */
	      {
		for (j = 0; j < 150; j++)	/*counter for the columns */
		  {
		    x[i][j] = 255;	/*to make all of the image white */
		    if (i == 0 || i == 149 || j == 0 || j == 149)	/*to add a black boarder to the image in the first and last columns and rows*/
		      {x[i][j] = 0;}		/*to make the boarders black */
		    if (j >= 65 && j <= 85 && i >= 150 - 10 * trial)	/*to add the trial counter */
		      x[i][j] = 0;
		  }
	      }			/*to make the trial counter black */
	    showArray (150, 150, x);	/*to show the image of trials */
	  }
	  break;		/*end of case 1 in switch statement */
	case 2:
	  {			/*beginning of case 2 in switch statement */
	    low = mid + 1;	/*to change the low value to become the previous mid value +1 */
	    trial++;		/*to increase the trial counter by 1 */
	  }
	  break;		/*end of case 2 in switch statement */
	case 3:
	  {			/*beginning of case 3 in switch statement */
	    high = mid - 1;	/*to change the high value to become the previous mid value -1 */
	    trial++;		/*to increase the trial counter by 1 */
	  }
	  break;		/*end of case 3 in switch statement */
	default: /*beginning of default case in switch statement*/
	  {printf ("Invalid choice.\n");}/*end of default case in switch statement */
	  } /*end of switch statement*/
      if (trial >= 15)	/*to not allow the user to try more than 15 times */
	{u = 1;		/*to exit the while loop */
	 printf("Hard luck! You were not able to find the secret number. :(\n");
	 printf ("The secret number is: %d\n", secnum);
	}    /*to display the secret number if the user tried 15 times */
    }				/*end of while loop */
}				/*end of startGuessTheNumberGame function */



void startHangmanGame ()		/*beginning of startHangmanGame function */
{
  int x;			/*resault of random funcion */
  int l;			/*string length */
  int i = 0;			/*for loops counter */
  int rem = 5;			/*number of remaining trials */
  int n;			/*to display a congratulations message if the player wins */
  int u=0;			/*for loop counter */
  int p = 0;			/*condition for do while loop */
  int r;			/*switch statement argumwnt */
  int input = 1;
  int cc=1;
  char guess = -1;
  char arr2[15][15] = { 0 };
  char arr[15][15];
  printf ("Hangman has started.\n");
  do				/*beginning of do while loop */
    {
      p = 0;
      printf ("Choose a category:\n");
      printf ("1. Food.\n");
      printf ("2. Objects.\n");
      printf ("3. Names.\n");
      printf ("4. Colors.\n");
      scanf ("%d", &r);		/*to insert the number of the category */
      srand (time (NULL));	/*to generate a random number */
      x = rand () % 15;		/*to generate a random number betwwen 0 and 14 and save it in variable x */
      switch (r){		/*beginning of switch statement */
	case 1:{		/*beginning of case 1 in switch statement */
	    FILE *food;        /*declare a file pointer*/
	    food = fopen ("food.txt", "r"); /*to open the food.txt file in read mode*/
	    if (food == NULL) /*checks if the file exist in the same folder of the project*/
	      {cc=0; /*to not enter the game if the file cannot be opened*/
	      printf ("Cannot open food.txt\n");}
	    else
	      {
		while (input == 1) /*beginning of while loop*/
		  {input = fscanf (food, "%s", arr[u]); /*to insert the words in food.txt file in arr in string format*/
		  u++;} /*counter*/ 
		fclose (food); /*to close the opened file*/
	      }
	  }break;		/*end of case 1 in switch statement */

	case 2:{             /*beginning of case 2 in switch statement */
	    FILE *objects; /*declare a file pointer*/
	    objects = fopen ("objects.txt", "r"); /*to open the objects.txt file in read mode*/
	    if (objects == NULL) /*checks if the file exist in the same folder of the project*/
	      {cc=0; /*to not enter the game if the file cannot be opened*/
	      printf ("Cannot open objects.txt\n");} 
	    else
	      {
		while (input == 1) /*beginning of while loop*/
		  {input = fscanf (objects, "%s", arr[u]); /*to insert the words in objects.txt file in arr in string format*/
		  u++;} /*counter*/
		fclose (objects); /*to close the opened file*/
	      }
	  }break;		/*end of case 2 in switch statement */

	case 3:{		/*beginning of case 3 in switch statement */
	    FILE *names;       /*declare a file pointer*/
	    names = fopen ("names.txt", "r"); /*to open the names.txt file in read mode*/
	    if (names == NULL) /*checks if the file exist in the same folder of the project*/
	      {cc=0; /*to not enter the game if the file cannot be opened*/
	      printf ("Cannot open names.txt\n");} 
	    else
	      {
		while (input == 1) /*beginning of while loop*/
		  {input = fscanf (names, "%s", arr[u]); /*to insert the words in names.txt file in arr in string format*/
		  u++;} /*counter*/
		fclose (names); /*to close the opened file*/
	      }
	  }break;  /*end of case 3 in switch statement*/

	case 4:{		/*beginning of case 4 in switch statement*/
	    FILE *colors;      /*declare a file pointer*/
	    colors = fopen ("colors.txt", "r"); /*to open the colors.txt file in read mode*/
	    if (colors == NULL) /*checks if the file exist in the same folder of the project*/
	      {cc=0; /*to not enter the game if the file cannot be opened*/
	      printf ("Cannot open colors.txt\n");} 
	    else
	      {
		while (input == 1) /*beginning of while loop*/
		  {input = fscanf (colors, "%s", arr[u]); /*to insert the words in colors.txt file in arr in string format*/
		  u++;} /*counter*/
		fclose (colors); /*to close the opened file*/
	      }
	  }break; /*end of case 4 in switch statement*/

	default: /*beginning of default case in switch statement*/
	  {printf ("Invalid choice.\n");
	    p = 1; /*to loop in the while loop*/
	  } /*end of default case in switch statement*/
	} /*end of switch statement*/

    }while (p != 0);		/*end of do while loop */


  l = strlen (arr[x]);		/*to find the string length of the x row in arr array */

int g; /*to determine whether the guess was correct or incorrect*/
  while (rem > 0 && cc==1){ /*beginning of while loop*/
      n = 1; /*initial value of n is 1*/
      g = 0; /*initial value of g is 0*/
      printf ("The word so far is:");

      for (i = 0; i < l; i++){ /*beginning of for loop*/
	  if (guess == arr[x][i])
	    {arr2[x][i] = guess; /*if the guess was correct the guess is entered into another array*/
	    printf (" %c", arr2[x][i]);} /*display the correct guess in the right location of the letter*/
	  else if (arr2[x][i] >= 'a' && arr2[x][i] <= 'z')
	    {printf (" %c", arr2[x][i]);} /*display all previous correct guesses*/
	  else
	    {printf (" _");
	    n = 0;} /*display an underscore for all letters that haven't been found yet*/ 
	} /*end of for loop*/
      printf (".\n");

      if (n == 0) /*if statement if there are numbers that haven't been found yet*/
	{
	  printf ("You have %d remaining attempts.\n", rem); /*display the remaining number of guesses*/
	  scanf (" %c", &guess); /*to enter your guess*/
	  n = 1; /*initial value of n is 1*/
	  for (i = 0; i < l; i++){ /*beginning of for loop*/
	      if (guess == arr[x][i]) /*if the guess is correct it gives g a value of 1*/
		{g = 1;}
	      if(arr[x][i]!=arr2[x][i])
                {if(guess!=arr[x][i])
                {n=0;}} /*give n a value of 0 if there are letters that haven't been found yet*/
               
	    } /*end of for loop*/
	  if (g == 0) /*if the guess is incorrect, it subtracts 1 from the number of the remaining trials*/
	    {rem--;}
	}



      //results of every guess
      if (n == 1)		/*if the player won the game, it displays a congratulations message, and exit the while loop */
	{printf ("Congratulations! You found the word!\nThe word is: %s\n", arr[x]);
	  rem = 0;}
      else if (rem == 0) /*if the number of remaining trials reached 0, it displays a hard luck message and the word, and exits the while*/
	{printf ("Hard luck! You were not able to find the word. :(\n");
	printf ("The word is: %s\n", arr[x]);}
      else if (g == 0) /*if the guess was incorrect and still have more than 0 remaining trials, it displays a not quite message*/
	{printf ("Not quite! Try agian!\n");}
      else /*if the guess was correct, it displays a correct message*/
	{printf ("Correct! Keep going!\n");}
    } /*end of while loop*/
} /*end of startHangman function*/

