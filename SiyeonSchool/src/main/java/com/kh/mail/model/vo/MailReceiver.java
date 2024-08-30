package com.kh.mail.model.vo;

public class MailReceiver {

	private String mailNo;
	private int receiverNo;
	private String receiverName;	// 수신인 이름
	private String receiverId; 		// 수신인 아이디
	private String receiverType;
	private String readTime;
	
	public MailReceiver() {}

	public MailReceiver(String mailNo, int receiverNo, String receiverName, String receiverId, String receiverType,
			String readTime) {
		super();
		this.mailNo = mailNo;
		this.receiverNo = receiverNo;
		this.receiverName = receiverName;
		this.receiverId = receiverId;
		this.receiverType = receiverType;
		this.readTime = readTime;
	}

	public String getMailNo() {
		return mailNo;
	}

	public void setMailNo(String mailNo) {
		this.mailNo = mailNo;
	}

	public int getReceiverNo() {
		return receiverNo;
	}

	public void setReceiverNo(int receiverNo) {
		this.receiverNo = receiverNo;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getReceiverType() {
		return receiverType;
	}

	public void setReceiverType(String receiverType) {
		this.receiverType = receiverType;
	}

	public String getReadTime() {
		return readTime;
	}

	public void setReadTime(String readTime) {
		this.readTime = readTime;
	}

	@Override
	public String toString() {
		return "MailReceiver [mailNo=" + mailNo + ", receiverNo=" + receiverNo + ", receiverName=" + receiverName
				+ ", receiverId=" + receiverId + ", receiverType=" + receiverType + ", readTime=" + readTime + "]";
	};
	
}
