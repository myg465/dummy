package com.bluebiz.board.dto;

import java.sql.Timestamp;

public class BoardDto {

	public BoardDto() {}
	

	public BoardDto(String title, String content, String id, Timestamp created_date, Timestamp modified_date,
			int board_id, String delete_flag) {
		super();
		this.title = title;
		this.content = content;
		this.id = id;
		this.created_date = created_date;
		this.modified_date = modified_date;
		this.board_id = board_id;
		this.delete_flag = delete_flag;
	}


	private String title;
	private String content;
	private String id;
	private Timestamp created_date;
	private Timestamp modified_date;
	private int board_id;
	private String delete_flag;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getCreated_date() {
		return created_date;
	}
	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}
	public Timestamp getModified_date() {
		return modified_date;
	}
	public void setModified_date(Timestamp modified_date) {
		this.modified_date = modified_date;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}



	public String getDelete_flag() {
		return delete_flag;
	}



	public void setDelete_flag(String delete_flag) {
		this.delete_flag = delete_flag;
	}
	
	
	
	
	
}
