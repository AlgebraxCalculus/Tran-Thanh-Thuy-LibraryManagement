/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FineDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import model.Fine;
import model.FineDetail;
import model.ReturnSlipDetail;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FineServlet", urlPatterns = {"/FineServlet"})
public class FineServlet extends HttpServlet {
    private FineDAO fineDAO;

    public void init() {
        fineDAO = new FineDAO();
    }
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FineServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FineServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String key = request.getParameter("key");
        ArrayList<Fine> searchResult = fineDAO.searchFine(key);
        request.setAttribute("result", searchResult);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/libraryStaff/SearchFine.jsp"); 
        dispatcher.forward(request, response);
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
        HttpSession session = request.getSession();

        ArrayList<FineDetail> listFineDetail = new ArrayList<>();
        String[] selectedFines = request.getParameterValues("applyFineFor");
        
        ArrayList<ReturnSlipDetail> listReturnSlipDetail = 
            (ArrayList<ReturnSlipDetail>) session.getAttribute("listReturnSlipDetail");

        if (selectedFines == null || selectedFines.length == 0) {
        response.sendRedirect("view/libraryStaff/ConfirmReturn.jsp");
        return;
        }
        Map<String, ArrayList<FineDetail>> fineDetailMap = new HashMap<>();
        for (String fineData : selectedFines) {
            String[] parts = fineData.split("_");
            if (parts.length < 2) continue;

            int fineId = Integer.parseInt(parts[0]);
            String barcode = parts[1];

            String noteParam = "note_" + fineId + "_" + barcode;
            String note = request.getParameter(noteParam);

            String fineName = request.getParameter("fineName_" + fineId + "_" + barcode);
            String fineAmountStr = request.getParameter("fineAmount_" + fineId + "_" + barcode);
            float fineAmount = 0;
            if (fineAmountStr != null && !fineAmountStr.isEmpty()) {
                fineAmount = Float.parseFloat(fineAmountStr);
            }

            Fine fine = new Fine();
            fine.setID(fineId);
            fine.setName(fineName);
            fine.setAmount(fineAmount);

            FineDetail fineDetail = new FineDetail();
            fineDetail.setFine(fine);
            fineDetail.setNote(note);
            
            fineDetailMap.computeIfAbsent(barcode, k -> new ArrayList<>()).add(fineDetail);
        }
        
        for (ReturnSlipDetail rsd : listReturnSlipDetail) {
            String barcode = rsd.getBorrowSlipDetail().getDocumentCopy().getBarcode();
            if (fineDetailMap.containsKey(barcode)) {
                rsd.setListFineDetail(fineDetailMap.get(barcode));
            }
        }
        session.setAttribute("listFineDetail", listFineDetail);
        response.sendRedirect("view/libraryStaff/ConfirmReturn.jsp");
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
