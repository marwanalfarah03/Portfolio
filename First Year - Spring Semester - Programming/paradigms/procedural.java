package paradigms;
import java.util.Scanner;
public class procedural {

	public static void main(String[] args) {
		int option = 0;
		int numOfAttempts = 0;
		System.out.println("Welcome to Guess the Number!");
		while(true)
		{
			
			System.out.println("To start the game press 1");
			System.out.println("To exit the game press 2");
			Scanner scan = new Scanner(System.in);
			option = scan.nextInt();
			switch(option)
			{
			case 1: 
				numOfAttempts = guessTheNumber();
				if(numOfAttempts != 0)
				{
					System.out.println("It took you " + numOfAttempts + " tries to reach the correct number");
				}
				break;
			case 2:
				System.out.println("\nThank you for playing guess the number!");
				return;
			default:
				System.out.println("Try Again!");
			}
		}
	}
	public static int guessTheNumber()
	{
		System.out.println("\nGuess the Number has started");
		int secretNumber = 0;
		int numOfAttempts = 0;
		int option1 = 0;
		int option2 = 0;
		int large = 10000;
		int small = 1;
		int mid;
		while(secretNumber < 1 || secretNumber > 10000)
		{
			System.out.print("Please enter the secret number between 1 and 10000: ");
			Scanner scan1 = new Scanner(System.in);
			secretNumber = scan1.nextInt();
			if(secretNumber < 1 || secretNumber > 10000)
			{
				System.out.println("Try Again!");
			}
		}
		while(option2 != 1)
		{
			mid = (large + small) / 2;
			System.out.println("\nPlease choose one of the following 3 options:");
			System.out.println("1. My guess is correct.");
			System.out.println("2. The secret number is larger than " + mid);
			System.out.println("3. The secret number is smaller than " + mid);
			Scanner scan2 = new Scanner(System.in);
			option2 = scan2.nextInt();
			if((secretNumber > mid && option2 != 2) || (secretNumber < mid && option2 != 3) || (secretNumber == mid && option2 != 1))
			{
				System.out.println("\nYou didn't answer the question correctly :(\nTry Again!\n");
				return 0;
			}
				
			switch(option2)
			{
			case 1: 
				numOfAttempts++;
				break;
			case 2:
				small = mid + 1;
				numOfAttempts++;
				break;
			case 3:
				large = mid - 1;
				numOfAttempts++;
				break;
			default:
					System.out.println("Try again!");
			}
		}
		return numOfAttempts;
	}
}
