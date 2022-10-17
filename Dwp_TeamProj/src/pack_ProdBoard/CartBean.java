package pack_ProdBoard;

public class CartBean {
	private int num;
	private String uId;
	private int pNum;
	private int pVolumn;
	
	private String pName;
	private int sellPrice;
	private String sysFileName;
	private int stockVolumn;
	
	public int getStockVolumn() {
		return stockVolumn;
	}
	public void setStockVolumn(int stockVolumn) {
		this.stockVolumn = stockVolumn;
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
	public int getpNum() {
		return pNum;
	}
	public void setpNum(int pNum) {
		this.pNum = pNum;
	}
	public int getpVolumn() {
		return pVolumn;
	}
	public void setpVolumn(int pVolumn) {
		this.pVolumn = pVolumn;
	}
	
	
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(int sellPrice) {
		this.sellPrice = sellPrice;
	}
	public String getSysFileName() {
		return sysFileName;
	}
	public void setSysFileName(String sysFileName) {
		this.sysFileName = sysFileName;
	}
}
