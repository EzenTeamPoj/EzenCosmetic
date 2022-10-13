package pack_ReviewBoard;

public class ReviewBoardBean {
	int totalReviewNum;
	int tblReviewNum;
	int prodNum;
	String regId;
	String regName;
	String subject;
	String content;
	String regDate;
	String ip;
	int love;
	String oriFileName;
	String sysFileName;
	int fileSize;
	
	public int getTotalReviewNum() {
		return totalReviewNum;
	}
	public void setTotalReviewNum(int totalReviewNum) {
		this.totalReviewNum = totalReviewNum;
	}
	public int getTblReviewNum() {
		return tblReviewNum;
	}
	public void setTblReviewNum(int tblReviewNum) {
		this.tblReviewNum = tblReviewNum;
	}
	public int getProdNum() {
		return prodNum;
	}
	public void setProdNum(int prodNum) {
		this.prodNum = prodNum;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getLove() {
		return love;
	}
	public void setLove(int love) {
		this.love = love;
	}

	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getSysFileName() {
		return sysFileName;
	}
	public void setSysFileName(String sysFileName) {
		this.sysFileName = sysFileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
}
