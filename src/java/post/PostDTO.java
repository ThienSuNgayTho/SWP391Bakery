/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package post;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author dell
 */
public class PostDTO implements Serializable{
    private int id;
    private String email;
    private String title;
    private String thumbnailLink;
    private Date uploadDate;
    private boolean status;
    private String detail;
    private String categoryId;
    private boolean onSlider;
    private Date updateDate;

    public PostDTO() {
    }

    public PostDTO(int id, String email, String title, String thumbnailLink, Date uploadDate, boolean status, String detail, String categoryId, boolean onSlider, Date updateDate) {
        this.id = id;
        this.email = email;
        this.title = title;
        this.thumbnailLink = thumbnailLink;
        this.uploadDate = uploadDate;
        this.status = status;
        this.detail = detail;
        this.categoryId = categoryId;
        this.onSlider = onSlider;
        this.updateDate = updateDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public boolean isOnSlider() {
        return onSlider;
    }

    public void setOnSlider(boolean onSlider) {
        this.onSlider = onSlider;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    
    
}
