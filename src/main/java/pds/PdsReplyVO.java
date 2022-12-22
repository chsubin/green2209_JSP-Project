package pds;

public class PdsReplyVO {
	private int idx;
	private int pdsIdx;
	private String mid;
	private String rDate;
	private String content;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getPdsIdx() {
		return pdsIdx;
	}
	public void setPdsIdx(int pdsIdx) {
		this.pdsIdx = pdsIdx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "PdsReplyVO [idx=" + idx + ", pdsIdx=" + pdsIdx + ", mid=" + mid + ", rDate=" + rDate + ", content="
				+ content + "]";
	}
	
	
	
	
}
