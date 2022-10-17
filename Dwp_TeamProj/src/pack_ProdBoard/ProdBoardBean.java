package pack_ProdBoard;

public class ProdBoardBean {
	private int num;
	private String regId;               /*regId : 상품 등록 ID */
	private String pName;
	private String pType;				/*pType : 상품분류*/
	private int stockVolumn;		/*stockVolumn: 재고*/
	private int salesVolumn;			/*salesVolumn : 판매량*/
	private int oriPrice;				/*oriPrice 원래 가격*/
	private int sellPrice;				/*sellPrice 실제 판매 가격*/
	private String [] sellLabel;		/*sellLabel : BEST, NEW, SALE, NONE*/
	private String content;			
	private String regTM;
	private int readCnt;					/*count : 조회수*/
	private String oriFileName;
	private String sysFileName;
	private int fileSize;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpType() {
		return pType;
	}
	public void setpType(String pType) {
		this.pType = pType;
	}
	public int getStockVolumn() {
		return stockVolumn;
	}
	public void setStockVolumn(int stockVolumn) {
		this.stockVolumn = stockVolumn;
	}
	public int getSalesVolumn() {
		return salesVolumn;
	}
	public void setSalesVolumn(int salesVolumn) {
		this.salesVolumn = salesVolumn;
	}
	public int getOriPrice() {
		return oriPrice;
	}
	public void setOriPrice(int oriPrice) {
		this.oriPrice = oriPrice;
	}
	public int getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}
	public String[] getSellLabel() {
		return sellLabel;
	}
	public void setSellLabel(String[] sellLabel) {
		this.sellLabel = sellLabel;
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
