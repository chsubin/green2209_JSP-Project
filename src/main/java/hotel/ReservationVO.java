package hotel;

public class ReservationVO {
	
	private int idx;
	private String rvIdx;
	private int roomIdx;
	private String roomName;
	private String rvDay;
	private int numOfCustom;
	private String checkIn;
	private String checkOut;
	private String rcheckIn;
	private String rcheckOut;
	private int adultF ;
	private int childF ;
	private String content ;
	private String mid ;
	private String name ;
	private String email;
	private String phoneNumber;
	private String city;
	private String cardName;
	private String cardNumber;
	private String expiration;
	private String rvSw;
	private int price ;
	
	private String fSName;

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getRvIdx() {
		return rvIdx;
	}

	public void setRvIdx(String rvIdx) {
		this.rvIdx = rvIdx;
	}

	public int getRoomIdx() {
		return roomIdx;
	}

	public void setRoomIdx(int roomIdx) {
		this.roomIdx = roomIdx;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRvDay() {
		return rvDay;
	}

	public void setRvDay(String rvDay) {
		this.rvDay = rvDay;
	}

	public int getNumOfCustom() {
		return numOfCustom;
	}

	public void setNumOfCustom(int numOfCustom) {
		this.numOfCustom = numOfCustom;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public String getRcheckIn() {
		return rcheckIn;
	}

	public void setRcheckIn(String rcheckIn) {
		this.rcheckIn = rcheckIn;
	}

	public String getRcheckOut() {
		return rcheckOut;
	}

	public void setRcheckOut(String rcheckOut) {
		this.rcheckOut = rcheckOut;
	}

	public int getAdultF() {
		return adultF;
	}

	public void setAdultF(int adultF) {
		this.adultF = adultF;
	}

	public int getChildF() {
		return childF;
	}

	public void setChildF(int childF) {
		this.childF = childF;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getExpiration() {
		return expiration;
	}

	public void setExpiration(String expiration) {
		this.expiration = expiration;
	}

	public String getRvSw() {
		return rvSw;
	}

	public void setRvSw(String rvSw) {
		this.rvSw = rvSw;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getfSName() {
		return fSName;
	}

	public void setfSName(String fSName) {
		this.fSName = fSName;
	}

	@Override
	public String toString() {
		return "ReservationVO [idx=" + idx + ", rvIdx=" + rvIdx + ", roomIdx=" + roomIdx + ", roomName=" + roomName
				+ ", rvDay=" + rvDay + ", numOfCustom=" + numOfCustom + ", checkIn=" + checkIn + ", checkOut=" + checkOut
				+ ", rcheckIn=" + rcheckIn + ", rcheckOut=" + rcheckOut + ", adultF=" + adultF + ", childF=" + childF
				+ ", content=" + content + ", mid=" + mid + ", name=" + name + ", email=" + email + ", phoneNumber="
				+ phoneNumber + ", city=" + city + ", cardName=" + cardName + ", cardNumber=" + cardNumber + ", expiration="
				+ expiration + ", rvSw=" + rvSw + ", price=" + price + ", fSName=" + fSName + "]";
	}
	
	
	
	
	
}
