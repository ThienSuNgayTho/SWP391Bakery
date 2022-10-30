/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import post.PostDAO;
import user.UserDTO;

/**
 *
 * @author dell
 */
@WebServlet(name = "AddPostController", urlPatterns = {"/AddPostController"})
public class AddPostController extends HttpServlet {
    private final String ERROR_PAGE = "AddNewPostPage.jsp";
    private final String SUCCESS_PAGE = "managePost";

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
        HttpSession session = request.getSession();
        String url = ERROR_PAGE;

        try {

            PostDAO dao = new PostDAO();
            String postPicName = "post_" + dao.getMaxPostId();

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
                            fileName = postPicName + itemName.substring(itemName.lastIndexOf("."));
                            postPicName = fileName;
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
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }//end while

                String postTitle = (String) params.get("txtPostTitle");
                String postCategory = (String) params.get("txtCategoryId");
                String postDetail = (String) params.get("txtPostDetail");
                
                Calendar c = Calendar.getInstance();
                Date createDate = new Date(c.getTimeInMillis());
                UserDTO currentUser = (UserDTO) session.getAttribute("CURRENT_USER");
                
                boolean result = dao.addNewPost(currentUser.getEmail(), postTitle, postPicName, createDate, true, postDetail, postCategory, false, createDate);
                if(result){
                    url = SUCCESS_PAGE;
                }
            }

        } catch (SQLException ex) {
            log("AddNewPostController _ SQL: " + ex.getCause());
        } catch (NamingException ex) {
            log("AddNewPostController _ Naming: " + ex.getCause());
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
