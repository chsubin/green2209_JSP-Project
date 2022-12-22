package pds;

public class PdsVO {
	private int idx;
	private String mid;
	private String midName;
	private String rvIdx;
	private int roomIdx;
	private String roomName;
	private String checkIn;
	private String checkOut;
	private String fName;
	private String fSName;
	private int fSize;
	private String title;
	private String fDate;
	private String content;
	private String hostIp;
	private int readNum;
	
	private int day_diff;
	private int hour_diff;
	
	private int replyCnt;
	
	private int preIdx;
	private String preTitle;
	private int nextIdx;
	private String nextTitle;
	
	
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
	public String getMidName() {
		return midName;
	}
	public void setMidName(String midName) {
		this.midName = midName;
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
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public String getfSName() {
		return fSName;
	}
	public void setfSName(String fSName) {
		this.fSName = fSName;
	}
	public int getfSize() {
		return fSize;
	}
	public void setfSize(int fSize) {
		this.fSize = fSize;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getfDate() {
		return fDate;
	}
	public void setfDate(String fDate) {
		this.fDate = fDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public int getDay_diff() {
		return day_diff;
	}
	public void setDay_diff(int day_diff) {
		this.day_diff = day_diff;
	}
	public int getHour_diff() {
		return hour_diff;
	}
	public void setHour_diff(int hour_diff) {
		this.hour_diff = hour_diff;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	public int getPreIdx() {
		return preIdx;
	}
	public void setPreIdx(int preIdx) {
		this.preIdx = preIdx;
	}
	public String getPreTitle() {
		return preTitle;
	}
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}
	public int getNextIdx() {
		return nextIdx;
	}
	public void setNextIdx(int nextIdx) {
		this.nextIdx = nextIdx;
	}
	public String getNextTitle() {
		return nextTitle;
	}
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}
	@Override
	public String toString() {
		return "PdsVO [idx=" + idx + ", mid=" + mid + ", midName=" + midName + ", rvIdx=" + rvIdx + ", roomIdx=" + roomIdx
				+ ", roomName=" + roomName + ", checkIn=" + checkIn + ", checkOut=" + checkOut + ", fName=" + fName
				+ ", fSName=" + fSName + ", fSize=" + fSize + ", title=" + title + ", fDate=" + fDate + ", content=" + content
				+ ", hostIp=" + hostIp + ", readNum=" + readNum + ", day_diff=" + day_diff + ", hour_diff=" + hour_diff
				+ ", replyCnt=" + replyCnt + ", preIdx=" + preIdx + ", preTitle=" + preTitle + ", nextIdx=" + nextIdx
				+ ", nextTitle=" + nextTitle + "]";
	}
	
		
}
