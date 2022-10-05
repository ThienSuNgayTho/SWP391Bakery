/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import category.CategoryDAO;
import category.CategoryDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import post.PostDAO;
import post.PostDTO;
import product.ProductDAO;
import product.ProductDTO;
import user.UserDAO;
import user.UserDTO;

/**
 *
 * @author dell
 */
@WebServlet(name = "HomeController", urlPatterns = {"/HomeController"})
public class HomeController extends HttpServlet {

    private final String HOME_PAGE = "Home.jsp";
    private final String HOME_PAGE_MARKETING = "GetMarketingStatisticController";
    private final String HOME_PAGE_SALE = "GetSaleStatisticController";
    private final String HOME_PAGE_ADMIN = "GetAdminStatisticController";

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

        String url = HOME_PAGE;
        ServletContext context = getServletContext();

        try {
//            ProductDAO dao = new ProductDAO();
//            dao.getAvailableProductList();
//            List<ProductDTO> productList = dao.getProductList();
//            context.setAttribute("ALL_AVAILABLE_PRODUCT_LIST", productList);
//            
//            CategoryDAO cateDao = new CategoryDAO();
//            List<CategoryDTO> categoryCakeList = cateDao.getCakeCategory();
//            context.setAttribute("CAKE_CATEGORY_LIST", categoryCakeList);
//            
//            cateDao.getAllCategory();
//            List<CategoryDTO> categoryList = cateDao.getCategoryList();
//            context.setAttribute("ALL_CATEGORY_LIST", categoryList);

            //Load Products to the homeapge
            ProductDAO dao = new ProductDAO();
            String indexString = request.getParameter("index");
            if (indexString == null) {
                indexString = "1";
            }
            int index = Integer.parseInt(indexString);
            int maxPages = dao.getMaxPagesBy8();

            CategoryDAO cateDao = new CategoryDAO();
            List<CategoryDTO> categoryCakeList = cateDao.getCakeCategory();
            context.setAttribute("CAKE_CATEGORY_LIST", categoryCakeList);
            List<CategoryDTO> categoryPostList = cateDao.getPostCategory();
            context.setAttribute("POST_CATEGORY_LIST", categoryPostList);
            PostDAO postDAO = new PostDAO();
            postDAO.getSliderPostList();
            List<PostDTO> postSliderList = postDAO.getPostList();
            context.setAttribute("POST_SLIDER_LIST", postSliderList);

            dao.getAvailableProductList(index);
            List<ProductDTO> productList = dao.getProductList();
            for (ProductDTO productDTO : productList) {
                if( !new ProductDAO().isAvailable(productDTO.getId())){
                    productDTO.setStatus(false);
                }
            }
            request.setAttribute("ALL_AVAILABLE_PRODUCT_LIST", productList);
            request.setAttribute("maxPages", maxPages);
            request.setAttribute("index", index);

            //Load all categories for both Post and Products
            cateDao.getAllCategory();
            List<CategoryDTO> categoryList = cateDao.getCategoryList();
            context.setAttribute("ALL_CATEGORY_LIST", categoryList);

            HttpSession sessionExist = request.getSession(false);
            UserDTO user = (UserDTO) sessionExist.getAttribute("CURRENT_USER");
            if (user == null) {
                //Login Using Cookies
                //1. Get cookies
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    Cookie lastCookie = cookies[cookies.length - 1];
                    String email = lastCookie.getName();
                    String password = lastCookie.getValue();

                    //2. Call DAO
                    UserDAO userDao = new UserDAO();
                    UserDTO result = userDao.checkLogin(email, password);

                    if (result != null) {
                        //create seesion to save information of the current user
                        HttpSession session = request.getSession();
                        session.setAttribute("CURRENT_USER", result);
                        //if the user is customer redirect to homepage
                        if (result.getRole().getRoleId() == 3) {
                            url = HOME_PAGE;
                        }
                        //if the user is admin redirect to admin homepage
                        if (result.getRole().getRoleId() == 0) {
                            url = HOME_PAGE_ADMIN;
                        }
                        //if the user is sale redirect to sale homepage
                        if (result.getRole().getRoleId() == 2) {
                            url = HOME_PAGE_SALE;
                        }
                        //if the user is marketing redirect to marketing homepage
                        if (result.getRole().getRoleId() == 1) {
                            url = HOME_PAGE_MARKETING;
                        }
                    }//end if result is true
                }//end if cookies is not null
            } else {
                //Redirect to different homepage based on role
                //if the user is customer redirect to homepage
                if (user.getRole().getRoleId() == 3) {
                    url = HOME_PAGE;
                }
                //if the user is admin redirect to admin homepage
                if (user.getRole().getRoleId() == 0) {
                    url = HOME_PAGE_ADMIN;
                }
                //if the user is sale redirect to sale homepage
                if (user.getRole().getRoleId() == 2) {
                    url = HOME_PAGE_SALE;
                }
                //if the user is marketing redirect to marketing homepage
                if (user.getRole().getRoleId() == 1) {
                    url = HOME_PAGE_MARKETING;
                }
            }
        } catch (SQLException ex) {
            log("HomeController _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("HomeController _ Naming " + ex.getCause());
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
