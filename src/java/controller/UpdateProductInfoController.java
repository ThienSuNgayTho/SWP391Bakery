/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import product.ProductDAO;

/**
 *
 * @author dell
 */
@WebServlet(name = "UpdateProductInfoController", urlPatterns = {"/UpdateProductInfoController"})
public class UpdateProductInfoController extends HttpServlet {
    private final String RESULT_PAGE = "manageProduct";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
//        String url = RESULT_PAGE;
//        String productId = request.getParameter("txtProductId");
//        String productName = request.getParameter("txtProductName");
//        String categoryId = request.getParameter("txtCategoryId");
//        String originalPrice = request.getParameter("txtOriginalPrice");
//        String productDescription = request.getParameter("txtProductDescription");
//        String salePrice = request.getParameter("txtSalePrice");
//        String availableStatus = request.getParameter("txtStatus");
//        String productStock = request.getParameter("txtProductStock");
//        String saleStatus = request.getParameter("txtSaleStatus");
//        boolean statusBoolean = false;
//        boolean saleStatusBoolean = false;
//        
//        if(availableStatus.equalsIgnoreCase("true")) statusBoolean = true;
//        if(saleStatus.equalsIgnoreCase("true")) saleStatusBoolean = true;
//        
//        try{
//
//                ProductDAO dao = new ProductDAO();
//                boolean result = dao.updateProductInfo(Integer.parseInt(productId),
//                        productName, categoryId, Float.parseFloat(originalPrice), productDescription,
//                        Float.parseFloat(salePrice), statusBoolean, Integer.parseInt(productStock), saleStatusBoolean);
//
//                if (result) {
//                    System.out.println("True");
//                    url = RESULT_PAGE;
//                }
//                else{
//                    System.out.println("False");
//                }
//            
//        }
//        catch(SQLException ex){
//            log("UpdateProductInfoServlet _ SQL " + ex.getCause());
//        }
//        catch(NamingException ex){
//            log("UpdateProductInfoServlet _ Naming " + ex.getCause());
//        }
//        finally{
//            //Dung ReqDispatcher se gay loi, do Delete dc goi boi Dispatch roi nen khong dc goi Dispatch tiep
//            response.sendRedirect(url);
//            //Van dam bao Security, chi khong con luu object
//            //Sau khi xoa khong can luu thong tin nua, nen response
//            out.close();
//        }
            boolean imageUpdate = false;
            String url = RESULT_PAGE;

        try {

            ProductDAO dao = new ProductDAO();
            String productPicName = "product_";

            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (!isMultiPart) {
                System.out.println("Fail");
            } else {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;

                try {
                    items = upload.parseRequest(request);
                } catch (FileUploadException ex) {
                    ex.printStackTrace();
                }

                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();

                String fileName = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        try {
                            String itemName = item.getName();
                            if (itemName.length() > 0) {
                                imageUpdate = true;
                                fileName = productPicName + Integer.parseInt((String) params.get("txtProductId")) + itemName.substring(itemName.lastIndexOf("."));
                                productPicName = fileName;
                                System.out.println(productPicName);
                                System.out.println("path" + fileName);
                                String path = getServletContext().getRealPath("/");
                                String RealPath = path + "images\\" + fileName;
                                System.out.println("Rpath:" + RealPath);

                                File savedFile = new File(RealPath);
                                if (savedFile.exists()) {
                                    savedFile.delete();
                                    System.out.println("Delete!");
                                }

                                item.write(savedFile);
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }//end while
                
                int productId = Integer.parseInt((String) params.get("txtProductId"));
                String productName = (String) params.get("txtProductName");
                System.out.println(productName);
                String productCategory = (String) params.get("txtCategoryId");
                String productDesc = (String) params.get("txtProductDescription");
                float productOriginalPrice = Float.parseFloat((String) params.get("txtOriginalPrice"));
                float productSalePrice = Float.parseFloat((String) params.get("txtSalePrice"));
                int productStock = Integer.parseInt((String) params.get("txtProductStock"));
                String status = (String)params.get("txtStatus");
                boolean productAvaiStatus = false;
                String saleStatus = (String)params.get("txtSaleStatus");
                boolean productSaleStatus = false;

                if(status.equalsIgnoreCase("true")) productAvaiStatus = true;
                if(saleStatus.equalsIgnoreCase("true")) productSaleStatus = true;
                
                if(imageUpdate == false){
                    productPicName = (String) params.get("currentImageLink");
                    System.out.println(productPicName);
                }

                boolean result = dao.updateProductInfo(productId, productName, productCategory, productPicName, productOriginalPrice, productDesc, productSalePrice, productAvaiStatus, productStock, productSaleStatus);
                if(result){
                    url = RESULT_PAGE;
                }
            }

        } catch (SQLException ex) {
            log("UpdateProductController _ SQL: " + ex.getCause());
        } catch (NamingException ex) {
            log("UpdateProductController _ Naming: " + ex.getCause());
        } finally {
//            RequestDispatcher rd = request.getRequestDispatcher(url);
//            rd.forward(request, response);
            response.sendRedirect(url);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
