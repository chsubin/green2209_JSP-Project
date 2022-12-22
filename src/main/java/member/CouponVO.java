package member;

public class CouponVO {
	private int idx;
	private String mid;
	private String startDay;
	private String lastDay;
	private String title;
	private int price;
	private String content;
	private String useSw;
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
	public String getStartDay() {
		return startDay;
	}
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}
	public String getLastDay() {
		return lastDay;
	}
	public void setLastDay(String lastDay) {
		this.lastDay = lastDay;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUseSw() {
		return useSw;
	}
	public void setUseSw(String useSw) {
		this.useSw = useSw;
	}
	public int getDay_diff() {
		return day_diff;
	}
	public void setDay_diff(int day_diff) {
		this.day_diff = day_diff;
	}
	@Override
	public String toString() {
		return "CouponVO [idx=" + idx + ", mid=" + mid + ", startDay=" + startDay + ", lastDay=" + lastDay + ", title="
				+ title + ", price=" + price + ", content=" + content + ", useSw=" + useSw + ", day_diff=" + day_diff + "]";
	}
	
}
