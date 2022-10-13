package pack_BBS;

public class BoardBean {

	private int num;    //글번호
	private String uId; //작성자ID
	private String uName; //작성자 이름
	private String bbsPw;	 //게시글 비밀번호
	private String subject; //글제목
	private String qnaType;  //qna 유형
	private String content; //글내용
	private int pos;  //답변글용(position, 답변글 순서)
	private int ref;  //답변글용(reference, 원본글/답변글 기준)
	private int depth;  //답변글용(답변글 들여쓰기)
	private String regTM;	// 게시글 등록시간
	private String ip;        // 게시글 작성자 IP주소
	private int readCnt;   // 조회수
	private String oriFileName;  // 첨부파일 원본 이름
	private String systemFileName; // 첨부파일 서버 저장 이름
	private int fileSize;         // 첨부파일 크기
	private String aName;
	private String asubject;
	private String acontent;
	public String getaName() {
		return aName;
	}
	public void setaName(String aName) {
		this.aName = aName;
	}
	public String getAsubject() {
		return asubject;
	}
	public void setAsubject(String asubject) {
		this.asubject = asubject;
	}
	public String getAcontent() {
		return acontent;
	}
	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getBbsPw() {
		return bbsPw;
	}
	public void setBbsPw(String bbsPw) {
		this.bbsPw = bbsPw;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getRegTM() {
		return regTM;
	}
	public void setRegTM(String regTM) {
		this.regTM = regTM;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getSystemFileName() {
		return systemFileName;
	}
	public void setSystemFileName(String systemFileName) {
		this.systemFileName = systemFileName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	
	
	
}
