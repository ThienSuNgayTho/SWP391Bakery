/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.io.Serializable;
import java.sql.Date;
import role.RoleDTO;

/**
 *
 * @author dell
 */
public class UserDTO implements Serializable{
    private String email;
    private String password;
    private String avatarLink;
    private String address;
    private String fullName;
    private String phoneNumber;
    private String gender;
    private Date creationDate;
    private boolean status;
    private RoleDTO role;

    //default contrustor
    public UserDTO() {
    }

    //parameter constructor
    public UserDTO(String email, String password, String avatarLink, String address, String fullName, String phoneNumber, String gender, Date creationDate, boolean status, RoleDTO role) {
        this.email = email;
        this.password = password;
        this.avatarLink = avatarLink;
        this.address = address;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.creationDate = creationDate;
        this.status = status;
        this.role = role;
    }

    //get user email
    public String getEmail() {
        return email;
    }

    //set user email
    public void setEmail(String email) {
        this.email = email;
    }

    //get user password
    public String getPassword() {
        return password;
    }

    //set user password
    public void setPassword(String password) {
        this.password = password;
    }

    //get user avatar
    public String getAvatarLink() {
        return avatarLink;
    }

    //set user avatar
    public void setAvatarLink(String avatarLink) {
        this.avatarLink = avatarLink;
    }

    //get user address
    public String getAddress() {
        return address;
    }

    //set user address
    public void setAddress(String address) {
        this.address = address;
    }

    //get user fullname
    public String getFullName() {
        return fullName;
    }

    //set user fullname
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    //get user phone number
    public String getPhoneNumber() {
        return phoneNumber;
    }

    //set user phone number
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    //get user gender
    public String getGender() {
        return gender;
    }

    //set user gender
    public void setGender(String gender) {
        this.gender = gender;
    }

    //get user account creation date
    public Date getCreationDate() {
        return creationDate;
    }

    //set user account creation date
    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    //get user account status
    public boolean isStatus() {
        return status;
    }

   //set user account status
    public void setStatus(boolean status) {
        this.status = status;
    }

    //get user role
    public RoleDTO getRole() {
        return role;
    }

    //set user role
    public void setRole(RoleDTO role) {
        this.role = role;
    }

    
}