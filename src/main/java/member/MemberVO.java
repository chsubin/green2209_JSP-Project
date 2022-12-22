package member;

public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nameKor;
	private String nameEng;
	private String gender;
	private String birthday;
	private String email;
	private String phoneNumber;
	private String homeNumber;
	private String address;
	private int level;
	private int point;
	private int memPoint;
	private String startDate ;
	private String lastDate;
	private String userDel;
	
	private int day_diff;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNameKor() {
		return nameKor;
	}

	public void setNameKor(String nameKor) {
		this.nameKor = nameKor;
	}

	public String getNameEng() {
		return nameEng;
	}

	public void setNameEng(String nameEng) {
		this.nameEng = nameEng;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getHomeNumber() {
		return homeNumber;
	}

	public void setHomeNumber(String homeNumber) {
		this.homeNumber = homeNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getMemPoint() {
		return memPoint;
	}

	public void setMemPoint(int memPoint) {
		this.memPoint = memPoint;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getLastDate() {
		return lastDate;
	}

	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}

	public String getUserDel() {
		return userDel;
	}

	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}

	public int getDay_diff() {
		return day_diff;
	}

	public void setDay_diff(int day_diff) {
		this.day_diff = day_diff;
	}

	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", nameKor=" + nameKor + ", nameEng=" + nameEng
				+ ", gender=" + gender + ", birthday=" + birthday + ", email=" + email + ", phoneNumber=" + phoneNumber
				+ ", homeNumber=" + homeNumber + ", address=" + address + ", level=" + level + ", point=" + point
				+ ", memPoint=" + memPoint + ", startDate=" + startDate + ", lastDate=" + lastDate + ", userDel=" + userDel
				+ ", day_diff=" + day_diff + "]";
	}
	
	
	
}
