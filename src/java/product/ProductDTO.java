/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import category.CategoryDTO;
import java.io.Serializable;

/**
 *
 * @author Dang Minh Quan
 */
public class ProductDTO implements Serializable{
    private int id;
    private String name;
    private String thumbnailLink;
    private float originalSalePrice;
    private String details;
    private float salePrice;
    private boolean status;
    private boolean saleStatus;
    private int stock;
    private CategoryDTO category ;

    public ProductDTO() {
    }

    public ProductDTO(String name, String thumbnailLink, float originalSalePrice, String details, float salePrice, boolean status, boolean SaleStatus, int stock, CategoryDTO category) {
        this.name = name;
        this.thumbnailLink = thumbnailLink;
        this.originalSalePrice = originalSalePrice;
        this.details = details;
        this.salePrice = salePrice;
        this.status = status;
        this.saleStatus = SaleStatus;
        this.stock = stock;
        this.category = category;
    }

    public ProductDTO(int id, String name, float originalSalePrice, String details, float salePrice, boolean status, boolean SaleStatus, int stock, CategoryDTO category) {
        this.id = id;
        this.name = name;
        this.originalSalePrice = originalSalePrice;
        this.details = details;
        this.salePrice = salePrice;
        this.status = status;
        this.saleStatus = SaleStatus;
        this.stock = stock;
        this.category = category;
    }

    public ProductDTO(int id, String name, String thumbnailLink, float originalSalePrice, String details, float salePrice, boolean status, boolean saleStatus, int stock, CategoryDTO category) {
        this.id = id;
        this.name = name;
        this.thumbnailLink = thumbnailLink;
        this.originalSalePrice = originalSalePrice;
        this.details = details;
        this.salePrice = salePrice;
        this.status = status;
        this.saleStatus = saleStatus;
        this.stock = stock;
        this.category = category;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public float getOriginalSalePrice() {
        return originalSalePrice;
    }

    public void setOriginalSalePrice(float originalSalePrice) {
        this.originalSalePrice = originalSalePrice;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public boolean isStatus() {
        return status;
    }
    
    public boolean getStatus(){
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isSaleStatus() {
        return saleStatus;
    }

    public boolean getSaleStatus(){
        return saleStatus;
    }
    
    public void setSaleStatus(boolean SaleStatus) {
        this.saleStatus = SaleStatus;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public CategoryDTO getCategory() {
        return category;
    }

    public void setCategory(CategoryDTO category) {
        this.category = category;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ProductDTO other = (ProductDTO) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }
    

    
}
