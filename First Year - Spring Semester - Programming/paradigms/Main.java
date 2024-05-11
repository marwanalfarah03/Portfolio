package paradigms;

public class Main {

	public static void main(String[] args) {		
		MainFrame mainFrame = new MainFrame();
		Administration admin1 = new Administration("21110011", "marwan321");
		admin1.setDateOfBirth("15/06/2003");
		admin1.setGender("Male");
		admin1.setName("Marwan Al Farah");
		admin1.setNationalID("2000676182");
		admin1.setNationality("Jordanian");
		admin1.setPlaceOfBirth("Amman");
	}

}
