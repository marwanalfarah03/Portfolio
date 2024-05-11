package paradigms;

import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

public class People {

	//attributes
	private static String name;
	private static String gender;
	private static String nationalID;
	private static String dateOfBirth;
	private static String placeOfBirth;
	private static String nationality;
	private static String username;
	private static String password;
	private static String department;
	private static int number = 0;
	private static int numberCopy = 0;
	private static int nameCount = 0;
	private static int genderCount = 0;
	private static int nationalIDCount = 0;
	private static int dateOfBirthCount = 0;
	private static int placeOfBirthCount = 0;
	private static int nationalityCount = 0;
	private static int usernameCount = 0;
	private static int passwordCount = 0;
	private static int departmentCount = 0;
	
	//encapsulation
	public static int getNameCount() {
		return nameCount;
	}
	public static void setNameCount(int nameCount) {
		People.nameCount = nameCount;
	}
	public static int getGenderCount() {
		return genderCount;
	}
	public static void setGenderCount(int genderCount) {
		People.genderCount = genderCount;
	}
	public static int getNationalIDCount() {
		return nationalIDCount;
	}
	public static void setNationalIDCount(int nationalIDCount) {
		People.nationalIDCount = nationalIDCount;
	}
	public static int getDateOfBirthCount() {
		return dateOfBirthCount;
	}
	public static void setDateOfBirthCount(int dateOfBirthCount) {
		People.dateOfBirthCount = dateOfBirthCount;
	}
	public static int getPlaceOfBirthCount() {
		return placeOfBirthCount;
	}
	public static void setPlaceOfBirthCount(int placeOfBirthCount) {
		People.placeOfBirthCount = placeOfBirthCount;
	}
	public static int getNationalityCount() {
		return nationalityCount;
	}
	public static void setNationalityCount(int nationalityCount) {
		People.nationalityCount = nationalityCount;
	}
	public static int getUsernameCount() {
		return usernameCount;
	}
	public static void setUsernameCount(int usernameCount) {
		People.usernameCount = usernameCount;
	}
	public static int getPasswordCount() {
		return passwordCount;
	}
	public static void setPasswordCount(int passwordCount) {
		People.passwordCount = passwordCount;
	}
	public static int getDepartmentCount() {
		return departmentCount;
	}
	public static void setDepartmentCount(int departmentCount) {
		People.departmentCount = departmentCount;
	}
	public static int getNumberCopy() {
		return numberCopy;
	}
	public static void setNumberCopy(int numberCopy) {
		People.numberCopy = numberCopy;
	}
	public static int getNumber() {
		return number;
	}
	public static void setNumber(int number) {
		People.number = number;
	}
	public static String getName() {
		return name;
	}
	public static void setName(String name) {
		record[0][nameCount] = name;
		nameCount++;
		People.name = name;
	}
	public static String getGender() {
		return gender;
	}
	public static void setGender(String gender) {
		record[1][genderCount] = gender;
		genderCount++;
		People.gender = gender;
	}
	public static String getNationalID() {
		return nationalID;
	}
	public static void setNationalID(String nationalID) {
		record[2][nationalIDCount] = nationalID;
		nationalIDCount++;
		People.nationalID = nationalID;
	}
	public static String getDateOfBirth() {
		return dateOfBirth;
	}
	public static void setDateOfBirth(String dateOfBirth) {
		record[3][dateOfBirthCount] = dateOfBirth;
		dateOfBirthCount++;
		People.dateOfBirth = dateOfBirth; 
		
	}
	public static String getPlaceOfBirth() {
		return placeOfBirth;
	}
	public static void setPlaceOfBirth(String placeOfBirth) {
		record[4][placeOfBirthCount] = placeOfBirth;
		placeOfBirthCount++;
		People.placeOfBirth = placeOfBirth;
	}
	public static String getNationality() {
		return nationality;
	}
	public static void setNationality(String nationality) {
		record[5][nationalityCount] = nationality;
		nationalityCount++;
		People.nationality = nationality;
	}
	public static String getUsername() {
		return username;
	}
	public static void setUsername(String username) {
		record[6][usernameCount] = username;
		usernameCount++;
		People.username = username;
	}
	public static String getPassword() {
		return password;
	}
	public static void setPassword(String password) {
		record[7][passwordCount] = password;
		passwordCount++;
		People.password = password;
	}
	public static String getDepartment() {
		return department;
	}
	public static void setDepartment(String department) {
		record[8][departmentCount] = department;
		departmentCount++;
		People.department = department;
	}
	
	//Record
	private static String[][] record = new String[11][2000];
	
	public static String[][] getRecord() {
		return record;
	}
	public static void setRecord(String record, int row, int column) {
		People.record[row][column] = record;
	}
	
	//methods
	//userpass method
	static void userpass()
	{
		People.setName(People.record[0][People.nameCount]);
		People.setGender(People.record[1][People.genderCount]);
		People.setNationalID(People.record[2][People.nationalIDCount]);
		People.setDateOfBirth(People.record[3][People.dateOfBirthCount]);
		People.setPlaceOfBirth(People.record[4][People.placeOfBirthCount]);
		People.setNationality(People.record[5][People.nationalityCount]);
		Teacher.setQual(People.record[9][People.nameCount - 1]);
		Teacher.setSalary(People.record[10][People.nameCount - 1]);

		//JFrame
		final JFrame frame3 = new JFrame();
		frame3.setVisible(true);
		frame3.setLayout(null);
		frame3.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame3.setSize(750, 750);
		
		//Password
		JLabel label2 = new JLabel("Password:");
		frame3.add(label2);
		label2.setBounds(125, 410, 200, 20);
		final JTextField textField2 = new JTextField("");
		frame3.add(textField2);
		textField2.setBounds(225, 395, 425, 50);
		textField2.setFont(new Font("Calibri", Font.BOLD, 25));
		
		//Username
		JLabel label1 = new JLabel("Username:");
		frame3.add(label1);
		label1.setBounds(125, 280, 200, 20);
		final JTextField textField1 = new JTextField(null);
		frame3.add(textField1);
		textField1.setBounds(225, 265, 425, 50);
		textField1.setFont(new Font("Calibri", Font.BOLD, 25));
		
		//Save
		JButton btn1 = new JButton("Save");
		frame3.add(btn1);
		btn1.setBounds(325, 600, 75, 75);
		btn1.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				if(!textField1.getText().equals("") && !textField2.getText().equals(""))
				{
					number = 0;
					while(People.record[6][number] != null)
					{
						if(MainFrame.user == People.record[6][number])
						{
							break;
						}
						number++;
					}
					
					if(People.record[8][number] == "Teacher")
					{
						Teacher teacher = new Teacher(textField1.getText(), textField2.getText());
					}
					else if(People.record[8][number] == "Student")
					{
						Student student = new Student(textField1.getText(), textField2.getText());
					}
					else if(People.record[8][number] == "Employee")
					{
						Employee employee = new Employee(textField1.getText(), textField2.getText());
					}
					frame3.hide();
					Administration.adminPage();
				}
				else
				{
					JOptionPane.showMessageDialog(null, "Please insert both the username AND password before you press save");
				}
			}
		});
		
	} //end of userpass method
	
	
	//personalProfile method
	static void personalProfile()
	{
		//JFrame
		final JFrame frame2 = new JFrame();
		frame2.setVisible(true);
		frame2.setLayout(null);
		frame2.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame2.setSize(750, 750);
		
		//Back
		JButton btn1 = new JButton("Back");
		frame2.add(btn1);
		btn1.setBounds(25, 25, 75, 75);
		btn1.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame2.hide();
				if((number != numberCopy) || number == 0)
				{
					number = numberCopy;
					Administration.adminPage();
				}
				if(People.record[8][number] == "Student")
				{
					Student.adminPage();
				}
				else if(People.record[8][number] == "Teacher")
				{
					Teacher.adminPage();
				}
				
				else if(People.record[8][number] == "Employee")
				{
					Employee.adminPage();
				}
			}
		});
		
		//Name
		JLabel label1 = new JLabel("Name:");
		frame2.add(label1);
		label1.setBounds(125, 150, 200, 20);
		final JTextField textField1 = new JTextField(People.record[0][number]);
		frame2.add(textField1);
		textField1.setBounds(225, 135, 425, 50);
		textField1.setEnabled(false);
		textField1.setFont(new Font("Calibri", Font.BOLD, 25));
		
		//Gender
		JLabel label2 = new JLabel("Gender:");
		frame2.add(label2);
		label2.setBounds(125, 215, 200, 20);
		final JTextField textField2 = new JTextField(People.record[1][number]);
		frame2.add(textField2);
		textField2.setBounds(225, 200, 425, 50);
		textField2.setEnabled(false);
		textField2.setFont(new Font("Calibri", Font.BOLD, 25));
				
		//National ID
		JLabel label3 = new JLabel("National ID:");
		frame2.add(label3);
		label3.setBounds(125, 280, 200, 20);
		final JTextField textField3 = new JTextField(People.record[2][number]);
		frame2.add(textField3);
		textField3.setBounds(225, 265, 425, 50);
		textField3.setEnabled(false);
		textField3.setFont(new Font("Calibri", Font.BOLD, 25));
				
		//Date of Birth
		JLabel label4 = new JLabel("Date of Birth:");
		frame2.add(label4);
		label4.setBounds(125, 345, 200, 20);
		final JTextField textField4 = new JTextField(People.record[3][number]);
		frame2.add(textField4);
		textField4.setBounds(225, 330, 425, 50);
		textField4.setEnabled(false);
		textField4.setFont(new Font("Calibri", Font.BOLD, 25));
			
		//Place of Birth
		JLabel label5 = new JLabel("Place of Birth:");
		frame2.add(label5);
		label5.setBounds(125, 410, 200, 20);
		final JTextField textField5 = new JTextField(People.record[4][number]);
		frame2.add(textField5);
		textField5.setBounds(225, 395, 425, 50);
		textField5.setEnabled(false);
		textField5.setFont(new Font("Calibri", Font.BOLD, 25));
			
		//Nationality
		JLabel label6 = new JLabel("Nationality:");
		frame2.add(label6);
		label6.setBounds(125, 475, 200, 20);
		final JTextField textField6 = new JTextField(People.record[5][number]);
		frame2.add(textField6);
		textField6.setBounds(225, 460, 425, 50);
		textField6.setEnabled(false);
		textField6.setFont(new Font("Calibri", Font.BOLD, 25));
				
		if(People.record[8][number] == "Teacher" || People.record[8][number] == "Employee")
		{
			//Qualifications
			JLabel label7 = new JLabel("Qualifications:");
			frame2.add(label7);
			label7.setBounds(125, 540, 200, 20);
			final JTextField textField7 = new JTextField(People.record[9][number]);
			frame2.add(textField7);
			textField7.setBounds(225, 525, 425, 50);
			textField7.setEnabled(false);
			textField7.setFont(new Font("Calibri", Font.BOLD, 25));	
			
			//Salary
			JLabel label8 = new JLabel("Salary:");
			frame2.add(label8);
			label8.setBounds(125, 605, 200, 20);
			final JTextField textField8 = new JTextField(People.record[10][number]);
			frame2.add(textField8);
			textField8.setBounds(225, 590, 425, 50);
			textField8.setEnabled(false);
			textField8.setFont(new Font("Calibri", Font.BOLD, 25));	
		}
		
		else if(People.record[8][number] == "Student")
		{
			//Grade/Year
			JLabel label7 = new JLabel("Grade/Year:");
			frame2.add(label7);
			label7.setBounds(125, 540, 200, 20);
			final JTextField textField7 = new JTextField(People.record[9][number]);
			frame2.add(textField7);
			textField7.setBounds(225, 525, 425, 50);
			textField7.setEnabled(false);
			textField7.setFont(new Font("Calibri", Font.BOLD, 25));	
		}
	}
	
}
