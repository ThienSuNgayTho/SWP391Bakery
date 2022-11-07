/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.ProductDAO;
import product.ProductDTO;

/**
 *
 * @author dell
 */
@WebServlet(name = "SearchProductController", urlPatterns = {"/SearchProductController"})
public class SearchProductController extends HttpServlet {

    String RESULT_PAGE = "Home.jsp";
    String HOME_PAGE = "HomeController";
    String MANAGE_PRODUCT_HOME_PAGE = "ManageProductController";
    String MANAGE_PRODUCT_RESULT_PAGE = "ManageProduct.jsp";

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String url = RESULT_PAGE;
        String searchValue = request.getParameter("txtSearchValue");
        String page = request.getParameter("jspname");
        if (page.equalsIgnoreCase("manageProduct")) {
            url = MANAGE_PRODUCT_RESULT_PAGE;
        }
        try {
            ProductDAO dao = new ProductDAO();
            String indexString = request.getParameter("index");
            if (indexString == null) {
                indexString = "1";
            }
            int index = Integer.parseInt(indexString);
            int maxPages = 0;
            maxPages = dao.getMaxPagesBy8();
            dao.getAvailableProductList(index);
            List<ProductDTO> orgResult = dao.getProductList();
            request.setAttribute("PRODUCT_LIST", orgResult);
            request.setAttribute("maxPages", maxPages);
            request.setAttribute("index", index);

            if (searchValue != null) {
                if (searchValue.trim().length() > 0) {
                    dao.ClearList();
                    if (page.equalsIgnoreCase("manageProduct")) {
                        maxPages = dao.getMaxPagesFullSearchNameBy8(searchValue);
                        dao.searchFullProductName(searchValue, index);
                    } else {
                        maxPages = dao.getMaxPagesSearchNameBy8(searchValue);
                        dao.searchProductName(searchValue, index);
                    }
                    List<ProductDTO> result = dao.getProductList();
                    System.out.println(result.size());
                    request.setAttribute("PRODUCT_LIST", result);
                    request.setAttribute("maxPages", maxPages);
                    request.setAttribute("index", index);
                } else if (page.equalsIgnoreCase("manageProduct")) {
                    url = MANAGE_PRODUCT_HOME_PAGE;
                } else {
                    url = HOME_PAGE;
                }
            } else if (page.equalsIgnoreCase("manageProduct")) {
                url = MANAGE_PRODUCT_HOME_PAGE;
            } else {
                url = HOME_PAGE;
            }
        } catch (SQLException ex) {
            log("SearchProductServlet _ SQL " + ex.getCause());
        } catch (NamingException ex) {
            log("SearchProductServlet _ Naming " + ex.getCause());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
