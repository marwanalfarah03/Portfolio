package paradigms;

import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;
public class MainFrame {
	public static String user = new String();
	MainFrame()
	{
		//JFrame
		final JFrame frame1 = new JFrame();
		frame1.setVisible(true);
		frame1.setLayout(null);
		frame1.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame1.setSize(750, 750);
		
		//JLabel
		JLabel label1 = new JLabel("Login:");
		frame1.add(label1);
		label1.setBounds(335, 40, 80, 20);
		label1.setFont(new Font("Calibri", Font.BOLD, 20));
		
		//JButtons
		JButton btn1 = new JButton("Administration");
		JButton btn2 = new JButton("Teacher");
		JButton btn3 = new JButton("Employee");
		JButton btn4 = new JButton("Student");
		frame1.add(btn1);
		frame1.add(btn2);
		frame1.add(btn3);
		frame1.add(btn4);
		btn1.setBounds(50, 100, 300, 250);
		btn2.setBounds(400, 100, 300, 250);
		btn3.setBounds(50, 400, 300, 250);
		btn4.setBounds(400, 400, 300, 250);
		btn1.setFont(new Font("Calibri", Font.BOLD, 40));
		btn2.setFont(new Font("Calibri", Font.BOLD, 40));
		btn3.setFont(new Font("Calibri", Font.BOLD, 40));
		btn4.setFont(new Font("Calibri", Font.BOLD, 40));
		
		//Administration
		btn1.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				int x = 0;
				boolean userBool = false;
				boolean passBool = false;
				String pass = new String();
				while(!userBool && user != null)
				{ 
					x = 0;
					user = JOptionPane.showInputDialog("Username");
					while(Administration.getUsers()[0][x] != null)
					{
						if(Administration.getUsers()[0][x].equals(user))
						{
							userBool = true;
							while(!passBool && pass != null)
							{
								pass = JOptionPane.showInputDialog("Password");
								if(Administration.getUsers()[1][x].equals(pass))
								{
									frame1.hide();
									Administration.adminPage();
									break;
								}
							}
						}
						x++;
					}
				}
			}
		});
		
		//Teacher
		btn2.addActionListener(new ActionListener() {
			
			public void actionPerformed(ActionEvent e) {
				int x = 0;
				boolean userBool = false;
				boolean passBool = false;
				String pass = new String();
				while(!userBool && user != null)
				{ 
					x = 0;
					user = JOptionPane.showInputDialog("Username");
					while(Teacher.getUsers()[0][x] != null)
					{
						if(Teacher.getUsers()[0][x].equals(user))
						{
							userBool = true;
							while(!passBool && pass != null)
							{
								pass = JOptionPane.showInputDialog("Password");
								if(Teacher.getUsers()[1][x].equals(pass))
								{
									frame1.hide();
									Teacher.adminPage();
									break;
								}
							}
						}
						x++;
					}
				}
				
			}
		});
		
			//Employee
			btn3.addActionListener(new ActionListener() {
				
				public void actionPerformed(ActionEvent e) {
					int x = 0;
					boolean userBool = false;
					boolean passBool = false;
					String pass = new String();
					while(!userBool && user != null)
					{ 
						x = 0;
						user = JOptionPane.showInputDialog("Username");
						while(Employee.getUsers()[0][x] != null)
						{
							if(Employee.getUsers()[0][x].equals(user))
							{
								userBool = true;
								while(!passBool && pass != null)
								{
									pass = JOptionPane.showInputDialog("Password");
									if(Employee.getUsers()[1][x].equals(pass))
									{
										frame1.hide();
										Employee.adminPage();
										break;
									}
								}
							}
							x++;
						}
					}
				}
			});
			
			//Student
			btn4.addActionListener(new ActionListener() {
				
				public void actionPerformed(ActionEvent e) {
					int x = 0;
					boolean userBool = false;
					boolean passBool = false;
					String pass = new String();
					while(!userBool && user != null)
					{ 
						x = 0;
						user = JOptionPane.showInputDialog("Username");
						while(Student.getUsers()[0][x] != null)
						{
							if(Student.getUsers()[0][x].equals(user))
							{
								userBool = true;
								while(!passBool && pass != null)
								{
									pass = JOptionPane.showInputDialog("Password");
									if(Student.getUsers()[1][x].equals(pass))
									{
										frame1.hide();
										Student.adminPage();
										break;
									}
								}
							}
							x++;
						}
					}				
				}
			});
	}
}
