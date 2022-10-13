package pack_Often;

public class BoardBean {

	private int num;    //글번호
	private String aId;
	private String subject; //글제목
	private String aName; //이름
	private String qnaType;  //qna 유형
	private String content; //글내용
	private String regTM;	// 게시글 등록시간
	private int readCnt;   // 조회수
	private String fileName;  // 첨부파일 원본 이름
	private int fileSize;         // 첨부파일 크기
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getaId() {
		return aId;
	}
	public void setaId(String aId) {
		this.aId = aId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getaName() {
		return aName;
	}
	public void setaName(String aName) {
		this.aName = aName;
	}
	public String getQnaType() {
		return qnaType;
	}
	public void setQnaType(String qnaType) {
		this.qnaType = qnaType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegTM() {
		return regTM;
	}
	public void setRegTM(String regTM) {
		this.regTM = regTM;
	}
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	
}