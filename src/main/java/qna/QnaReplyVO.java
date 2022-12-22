package qna;

public class QnaReplyVO {
	private int idx;
	private int qnaIdx;
	private String mid;
	private String rDate;
	private String content;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getQnaIdx() {
		return qnaIdx;
	}
	public void setQnaIdx(int qnaIdx) {
		this.qnaIdx = qnaIdx;
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
		return "QnaReplyVO [idx=" + idx + ", qnaIdx=" + qnaIdx + ", mid=" + mid + ", rDate=" + rDate + ", content="
				+ content + "]";
	}

	
	
}
