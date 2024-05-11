package paradigms;

import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

public class Administration extends Teacher {

	
	private static int i = 0;
	private static String[][] users = new String[2][2000];
	
	//encapsulation
	public static String[][] getUsers() {
		return users;
	}
	public static void setUsers(String[][] users) {
		Administration.users = users;
	}
	
	//constructors
	Administration(String username, String password) {
		users[0][i] = username;
		users[1][i] = password;
		i++;
		People.setUsername(username);
		People.setPassword(password);
		People.setDepartment("Administration");
	}
	Administration() {
		
	}
	
	//methods
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
		
		//JFrame
		final JFrame frame1 = new JFrame();
		frame1.setVisible(true);
		frame1.setLayout(null);
		frame1.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame1.setSize(750, 750);
		
		//Personal Profile
		JButton btn1 = new JButton("Personal Profile");
		frame1.add(btn1);
		btn1.setBounds(50, 50, 200, 100);
		btn1.setFont(new Font("Calibri", Font.BOLD, 20));
		
		//Search
		final JTextField textField = new JTextField("Search");
		frame1.add(textField);
		textField.setEnabled(false);
		textField.setBounds(285, 75, 250, 50);
		frame1.addMouseListener(new MouseListener() {
			
			public void mouseReleased(MouseEvent e) {
				
				
			}
			
			public void mousePressed(MouseEvent e) {
				
				
			}
			
			public void mouseExited(MouseEvent e) {
				
				
			}
			
			public void mouseEntered(MouseEvent e) {
				
				
			}
			
			public void mouseClicked(MouseEvent e) {
				textField.setEnabled(false);
				textField.setText("Search");
			}
		});
		
		textField.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				textField.setEnabled(true);
				textField.setText(null);
			}
		});
		
		textField.addKeyListener(new KeyListener() {
			
			public void keyTyped(KeyEvent e) {
				
			}
			
			public void keyReleased(KeyEvent e) {
				
			}
			
			public void keyPressed(KeyEvent e) {
				if(e.getKeyCode() == 10)
				{
					People.setNumber(0);
					while(People.getRecord()[0][People.getNumber()] != null)
					{
						if(textField.getText().equals(People.getRecord()[0][People.getNumber()]))
						{
							People.personalProfile();
							frame1.hide();
							break;
						}
						People.setNumber(People.getNumber() + 1);
					}
				}
			}
		});
		
		btn1.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame1.hide();
				personalProfile();
			}
		});
				
		//Log Out
		JButton btn2 = new JButton("Log out");
		frame1.add(btn2);
		btn2.setBounds(575, 50, 125, 100);
		btn2.setFont(new Font("Calibri", Font.BOLD, 15));
		btn2.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame1.hide();
				MainFrame mainFrame = new MainFrame();	
			}
		});
		
		//JButtons
		JButton btn3 = new JButton("Create Student Account");
		JButton btn4 = new JButton("Create Teacher Account");
		JButton btn5 = new JButton("Create Employee Account");
		frame1.add(btn3);
		frame1.add(btn4);
		frame1.add(btn5);
		btn3.setBounds(225, 275, 275, 100);
		btn4.setBounds(50, 425, 275, 100);
		btn5.setBounds(375, 425, 275, 100);
		btn3.setFont(new Font("Calibri", Font.BOLD, 20));
		btn4.setFont(new Font("Calibri", Font.BOLD, 20));
		btn5.setFont(new Font("Calibri", Font.BOLD, 20));
		
		//Create Student Account
		btn3.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame1.hide();
				Student.createAccount();
			}
		});
		
		//Create Teacher Account
		btn4.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				frame1.hide();
				Teacher.createAccount();
			}
		});
		
		//Create Employee Account
				btn5.addActionListener(new ActionListener() {
					
					public void actionPerformed(ActionEvent e) {
						frame1.hide();
						Employee.createAccount();
					}
				});
	}

	//personalProfile method
	static void personalProfile()
	{
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
				adminPage();
			}
		});
		
		//Name
		JLabel label1 = new JLabel("Name:");
		frame2.add(label1);
		label1.setBounds(125, 150, 200, 20);
		final JTextField textField1 = new JTextField(People.getRecord()[0][0]);
		frame2.add(textField1);
		textField1.setBounds(225, 135, 425, 50);
		textField1.setEnabled(false);
		textField1.setFont(new Font("Calibri", Font.BOLD, 25));
				
		//Gender
		JLabel label2 = new JLabel("Gender:");
		frame2.add(label2);
		label2.setBounds(125, 215, 200, 20);
		final JTextField textField2 = new JTextField(People.getRecord()[1][0]);
		frame2.add(textField2);
		textField2.setBounds(225, 200, 425, 50);
		textField2.setEnabled(false);
		textField2.setFont(new Font("Calibri", Font.BOLD, 25));
		
		//National ID
		JLabel label3 = new JLabel("National ID:");
		frame2.add(label3);
		label3.setBounds(125, 280, 200, 20);
		final JTextField textField3 = new JTextField(People.getRecord()[2][0]);
		frame2.add(textField3);
		textField3.setBounds(225, 265, 425, 50);
		textField3.setEnabled(false);
		textField3.setFont(new Font("Calibri", Font.BOLD, 25));
			
		//Date of Birth
		JLabel label4 = new JLabel("Date of Birth:");
		frame2.add(label4);
		label4.setBounds(125, 345, 200, 20);
		final JTextField textField4 = new JTextField(People.getRecord()[3][0]);
		frame2.add(textField4);
		textField4.setBounds(225, 330, 425, 50);
		textField4.setEnabled(false);
		textField4.setFont(new Font("Calibri", Font.BOLD, 25));
			
		//Place of Birth
		JLabel label5 = new JLabel("Place of Birth:");
		frame2.add(label5);
		label5.setBounds(125, 410, 200, 20);
		final JTextField textField5 = new JTextField(People.getRecord()[4][0]);
		frame2.add(textField5);
		textField5.setBounds(225, 395, 425, 50);
		textField5.setEnabled(false);
		textField5.setFont(new Font("Calibri", Font.BOLD, 25));
			
		//Nationality
		JLabel label6 = new JLabel("Nationality:");
		frame2.add(label6);
		label6.setBounds(125, 475, 200, 20);
		final JTextField textField6 = new JTextField(People.getRecord()[5][0]);
		frame2.add(textField6);
		textField6.setBounds(225, 460, 425, 50);
		textField6.setEnabled(false);
		textField6.setFont(new Font("Calibri", Font.BOLD, 25));
				
		//Enable Editing
		final JButton btn3 = new JButton("Enable Editing");
		frame2.add(btn3);
		btn3.setBounds(400, 25, 300, 75);
				
		//Save
		final JButton btn4 = new JButton("Save");
		frame2.add(btn4);
		btn4.setBounds(300, 550, 100, 100);
		btn4.setEnabled(false);
		btn4.addActionListener(new ActionListener() {
				
			public void actionPerformed(ActionEvent e) {
				if(!textField1.getText().equals("") && !textField2.getText().equals("") && !textField3.getText().equals("") && !textField4.getText().equals("") && !textField5.getText().equals("") && !textField6.getText().equals(""))
				{
					setRecord(textField1.getText(), 0, 0);
					setRecord(textField2.getText(), 1, 0);
					setRecord(textField3.getText(), 2, 0);
					setRecord(textField4.getText(), 3, 0);
					setRecord(textField5.getText(), 4, 0);
					setRecord(textField6.getText(), 5, 0);
					btn3.setText("Enable Editing");
					btn4.setEnabled(false);
					textField1.setEnabled(false);
					textField2.setEnabled(false);
					textField3.setEnabled(false);
					textField4.setEnabled(false);
					textField5.setEnabled(false);
					textField6.setEnabled(false);
				}
				else
				{
					JOptionPane.showMessageDialog(null, "Fill all the blanks before clicking on save");
				}
					
			}
		});
		
		//Enable Editing
				
		btn3.addActionListener(new ActionListener() {
					
			public void actionPerformed(ActionEvent e) {
				if(btn3.getText().equals("Enable Editing"))
				{
					textField1.setEnabled(true);
					textField2.setEnabled(true);
					textField3.setEnabled(true);
					textField4.setEnabled(true);
					textField5.setEnabled(true);
					textField6.setEnabled(true);
					btn3.setText("Disable Editing");
					btn4.setEnabled(true);
				}
				else
				{
					textField1.setEnabled(false);
					textField2.setEnabled(false);
					textField3.setEnabled(false);
					textField4.setEnabled(false);
					textField5.setEnabled(false);
					textField6.setEnabled(false);
					btn3.setText("Enable Editing");
					textField1.setText(People.getRecord()[0][0]);
					textField2.setText(People.getRecord()[1][0]);
					textField3.setText(People.getRecord()[2][0]);
					textField4.setText(People.getRecord()[3][0]);
					textField5.setText(People.getRecord()[4][0]);
					textField6.setText(People.getRecord()[5][0]);
					btn4.setEnabled(false);
				}
					
			}
		});
	}

}
