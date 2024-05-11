package paradigms;

import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

public class Student {

	//attributes
	private static int i = 0;
	private static String[][] users = new String[2][2000];
	private static String year;
	
	//encapsulation
	public static String[][] getUsers() {
		return users;
	}
	public static void setUsers(String[][] users) {
		Student.users = users;
	}
	public static String getYear() {
		return year;
	}
	public static void setYear(String year) {
		People.setDepartment("Student");
		People.setRecord(year, 9, (People.getNameCount() - 1));
		Student.year = year;
	}
	
	//constructors
	Student(String username, String password) {
		users[0][i] = username;
		users[1][i] = password;
		i++;
		People.setUsername(username);
		People.setPassword(password);
	}
	Student() {
		
	}
		
	//methods
	//createAccount method
	static void createAccount()
	{
		//JFrame
		final JFrame frame2 = new JFrame();
		frame2.setVisible(true);
		frame2.setLayout(null);
		frame2.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame2.setSize(750, 750);
		
		//Back button
		final JButton btn1 = new JButton("Back");
		frame2.add(btn1);
		btn1.setBounds(25, 25, 75, 75);
		btn1.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame2.hide();
				Administration.adminPage();
			}
		});
		
		//Name
		JLabel label1 = new JLabel("Name:");
		frame2.add(label1);
		label1.setBounds(125, 150, 200, 20);
		final JTextField textField1 = new JTextField(null);
		frame2.add(textField1);
		textField1.setBounds(225, 135, 425, 50);
		textField1.setFont(new Font("Calibri", Font.BOLD, 25));
				
		//Gender
		JLabel label2 = new JLabel("Gender:");
		frame2.add(label2);
		label2.setBounds(125, 215, 200, 20);
		final JTextField textField2 = new JTextField(null);
		frame2.add(textField2);
		textField2.setBounds(225, 200, 425, 50);
		textField2.setFont(new Font("Calibri", Font.BOLD, 25));
						
		//National ID
		JLabel label3 = new JLabel("National ID:");
		frame2.add(label3);
		label3.setBounds(125, 280, 200, 20);
		final JTextField textField3 = new JTextField(null);
		frame2.add(textField3);
		textField3.setBounds(225, 265, 425, 50);
		textField3.setFont(new Font("Calibri", Font.BOLD, 25));
						
		//Date of Birth
		JLabel label4 = new JLabel("Date of Birth:");
		frame2.add(label4);
		label4.setBounds(125, 345, 200, 20);
		final JTextField textField4 = new JTextField(null);
		frame2.add(textField4);
		textField4.setBounds(225, 330, 425, 50);
		textField4.setFont(new Font("Calibri", Font.BOLD, 25));
					
		//Place of Birth
		JLabel label5 = new JLabel("Place of Birth:");
		frame2.add(label5);
		label5.setBounds(125, 410, 200, 20);
		final JTextField textField5 = new JTextField(null);
		frame2.add(textField5);
		textField5.setBounds(225, 395, 425, 50);
		textField5.setFont(new Font("Calibri", Font.BOLD, 25));
					
		//Nationality
		JLabel label6 = new JLabel("Nationality:");
		frame2.add(label6);
		label6.setBounds(125, 475, 200, 20);
		final JTextField textField6 = new JTextField(null);
		frame2.add(textField6);
		textField6.setBounds(225, 460, 425, 50);
		textField6.setFont(new Font("Calibri", Font.BOLD, 25));
				
		//Grade/Year
		JLabel label7 = new JLabel("Grade/Year:");
		frame2.add(label7);
		label7.setBounds(125, 540, 200, 20);
		final JTextField textField7 = new JTextField(null);
		frame2.add(textField7);
		textField7.setBounds(225, 525, 425, 50);
		textField7.setFont(new Font("Calibri", Font.BOLD, 25));
		
		//Enable Editing button
		final JButton btn3 = new JButton("Enable Editing");
		btn3.setBounds(400, 25, 300, 75);
		frame2.add(btn3);
		btn3.setEnabled(false);
					
		//Next button
		final JButton btn5 = new JButton("Next");
		frame2.add(btn5);
		btn5.setBounds(550, 600, 75, 75);
		btn5.setEnabled(false);
		btn5.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame2.hide();
				People.userpass();
			}
		});
		
		//Save button
		final JButton btn4 = new JButton("Save");
		frame2.add(btn4);
		btn4.setBounds(325, 600, 75, 75);
		btn4.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				if(!textField1.getText().equals("") && !textField2.getText().equals("") && !textField3.getText().equals("") && !textField4.getText().equals("") && !textField5.getText().equals("") && !textField6.getText().equals("") && !textField7.getText().equals(""))
				{
					btn3.setEnabled(true);
					btn3.setText("Enable Editing");
					People.setRecord(textField1.getText(), 0, People.getNameCount());
					People.setRecord(textField2.getText(), 1, People.getGenderCount());
					People.setRecord(textField3.getText(), 2, People.getNationalIDCount());
					People.setRecord(textField4.getText(), 3, People.getDateOfBirthCount());
					People.setRecord(textField5.getText(), 4, People.getPlaceOfBirthCount());
					People.setRecord(textField6.getText(), 5, People.getNationalityCount());
					People.setRecord("Student", 8, People.getNameCount());
					People.setRecord(textField7.getText(), 9, People.getNameCount());
					Student.setYear(textField7.getText());
					textField1.setEnabled(false);
					textField2.setEnabled(false);
					textField3.setEnabled(false);
					textField4.setEnabled(false);
					textField5.setEnabled(false);
					textField6.setEnabled(false);
					textField7.setEnabled(false);
					btn4.setEnabled(false);
					btn5.setEnabled(true);
					btn1.setEnabled(false);
					System.out.println(People.getRecord()[8][People.getNameCount()]);
				}
				
				else
				{
					JOptionPane.showMessageDialog(null, "Fill all the blanks before clicking on save");
				}
			}
		});
		
		//Enable Editing button action listener
		btn3.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				if(btn3.isEnabled())
				{
					if(btn3.getText().equals("Enable Editing"))
					{
						textField1.setEnabled(true);
						textField2.setEnabled(true);
						textField3.setEnabled(true);
						textField4.setEnabled(true);
						textField5.setEnabled(true);
						textField6.setEnabled(true);
						textField7.setEnabled(true);
						btn3.setText("Disable Editing");
						btn4.setEnabled(true);
						btn5.setEnabled(false);
					}
					
					else
					{
						textField1.setEnabled(false);
						textField2.setEnabled(false);
						textField3.setEnabled(false);
						textField4.setEnabled(false);
						textField5.setEnabled(false);
						textField6.setEnabled(false);
						textField7.setEnabled(false);
						btn3.setText("Enable Editing");
						textField1.setText(People.getRecord()[0][People.getNameCount()]);
						textField2.setText(People.getRecord()[1][People.getGenderCount()]);
						textField3.setText(People.getRecord()[2][People.getNationalIDCount()]);
						textField4.setText(People.getRecord()[3][People.getDateOfBirthCount()]);
						textField5.setText(People.getRecord()[4][People.getPlaceOfBirthCount()]);
						textField6.setText(People.getRecord()[5][People.getNationalityCount()]);
						textField7.setText(People.getRecord()[9][People.getNameCount()]);
						btn4.setEnabled(false);
						btn5.setEnabled(true);
					}
				}
			}
		});
	} //end of createAccount method
	
	
	
	//adminPage method
	static void adminPage()
	{
		People.setNumber(0);
		while(People.getRecord()[6][People.getNumber()] != null)
		{
			if(MainFrame.user.equals(People.getRecord()[6][People.getNumber()]))
			{
				break;
			}
			People.setNumber(People.getNumber() + 1);
		}
		People.setNumberCopy(People.getNumber());
		final JFrame frame4 = new JFrame();
		frame4.setVisible(true);
		frame4.setLayout(null);
		frame4.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame4.setSize(750, 750);
		
		//Personal Profile
		JButton btn1 = new JButton("Personal Profile");
		frame4.add(btn1);
		btn1.setBounds(50, 50, 200, 100);
		btn1.setFont(new Font("Calibri", Font.BOLD, 20));
		btn1.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame4.hide();
				People.personalProfile();
			}
		});
				
		//Log Out
		JButton btn2 = new JButton("Log out");
		frame4.add(btn2);
		btn2.setBounds(575, 50, 125, 100);
		btn2.setFont(new Font("Calibri", Font.BOLD, 15));
		btn2.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame4.hide();
				MainFrame mainFrame = new MainFrame();
			}
		});
	}
}
