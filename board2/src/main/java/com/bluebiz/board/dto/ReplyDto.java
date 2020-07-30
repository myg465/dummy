package com.bluebiz.board.dto;

import java.sql.Timestamp;

public class ReplyDto {

	public ReplyDto() {}
	
	
	public ReplyDto(int reply_id, String reply_content, String user_id, int parent_id, Timestamp reply_date,
			Timestamp reply_modified_date, String reply_dflag) {
		super();
		this.reply_id = reply_id;
		this.reply_content = reply_content;
		this.user_id = user_id;
		this.parent_id = parent_id;
		this.reply_date = reply_date;
		this.reply_modified_date = reply_modified_date;
		this.reply_dflag = reply_dflag;
	}

	private int reply_id;
	private String reply_content;
	private String user_id;
	private int parent_id;
	private Timestamp reply_date;
	private Timestamp reply_modified_date;
	private String reply_dflag;
	
	
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public Timestamp getReply_date() {
		return reply_date;
	}
	public void setReply_date(Timestamp reply_date) {
		this.reply_date = reply_date;
	}
	public Timestamp getReply_modified_date() {
		return reply_modified_date;
	}
	public void setReply_modified_date(Timestamp reply_modified_date) {
		this.reply_modified_date = reply_modified_date;
	}
	public String getReply_dflag() {
		return reply_dflag;
	}
	public void setReply_dflag(String reply_dflag) {
		this.reply_dflag = reply_dflag;
	}
	
	
	
}
