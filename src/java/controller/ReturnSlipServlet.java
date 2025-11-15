/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BorrowSlipDAO;
import dao.BorrowSlipDetailDAO;
import dao.ReturnSlipDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BorrowSlip;
import model.BorrowSlipDetail;
import model.Reader;
import model.ReturnSlip;
import model.ReturnSlipDetail;
import model.Staff;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ReturnSlipServlet", urlPatterns = {"/ReturnSlipServlet"})
public class ReturnSlipServlet extends HttpServlet {
    
    private BorrowSlipDAO borrowSlipDAO;
    private ReturnSlipDAO returnSlipDAO;
    private BorrowSlipDetailDAO borrowSlipDetailDAO;

    public void init() {
        borrowSlipDAO = new BorrowSlipDAO();
        returnSlipDAO = new ReturnSlipDAO();
        borrowSlipDetailDAO = new BorrowSlipDetailDAO();
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
            out.println("<title>Servlet ReturnSlipServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReturnSlipServlet at " + request.getContextPath() + "</h1>");
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
        int readerId = Integer.parseInt(request.getParameter("readerId"));
        ArrayList<BorrowSlip> borrowedDocumentResult = borrowSlipDAO.getBorrowedDocumentByReader(readerId);
        
        HttpSession session = request.getSession();
        session.setAttribute("readerId", readerId);
        session.setAttribute("borrowedList", borrowedDocumentResult);
        
        request.getRequestDispatcher("view/libraryStaff/BorrowedDocument.jsp").forward(request, response);
        
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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action.equals("selectReaderToReturn")) {
            Reader reader = new Reader();
            reader.setID(Integer.parseInt(request.getParameter("readerID")));
            reader.setFullName(request.getParameter("fullName"));
            reader.setAddress(request.getParameter("address"));
            reader.setPhoneNumber(request.getParameter("phoneNumber"));
            
            session.setAttribute("reader", reader);

            // Gọi lại doGet() để hiển thị BorrowedDocument.jsp
            response.sendRedirect("ReturnSlipServlet?readerId=" + reader.getID());
        } else if (action.equals("selectDocumentsToReturn")) {
            ArrayList<BorrowSlip> borrowedDocumentResult = (ArrayList<BorrowSlip>) session.getAttribute("borrowedList");
            String[] selectedIDs = request.getParameterValues("selectedBorrowSlipDetailIDs");
            if (selectedIDs == null || selectedIDs.length == 0) {
                request.getSession().setAttribute("errorMessage", 
                    "You must select at least one document to return.");
                response.sendRedirect("view/libraryStaff/BorrowedDocument.jsp");
                return;
            }
            ArrayList<ReturnSlipDetail> listReturnSlipDetail = new ArrayList<>();
            if (selectedIDs != null) {
                // Duyệt qua tất cả BorrowSlip hiện có
                for (BorrowSlip borrowSlip : borrowedDocumentResult) {
                    for (BorrowSlipDetail borrowDetail : borrowSlip.getListBorrowSlipDetail()) {
                        for (String idStr : selectedIDs) {
                            int id = Integer.parseInt(idStr);
                            if (borrowDetail.getID() == id) {
                                // Tạo ReturnSlipDetail mới
                                ReturnSlipDetail rsd = new ReturnSlipDetail();
                                rsd.setBorrowSlipDetail(borrowDetail);
                                LocalDate dueDate = rsd.getBorrowSlipDetail().getDueDate();
                                LocalDate returnDate = LocalDate.now();

                                int overdueDays = (int) ChronoUnit.DAYS.between(dueDate, returnDate);
                                if (overdueDays < 0) overdueDays = 0; // Không để âm
                                rsd.setOverdueDays(overdueDays);
                                listReturnSlipDetail.add(rsd);
                            }
                        }
                    }
                }
            }
            session.setAttribute("listReturnSlipDetail", listReturnSlipDetail);
            response.sendRedirect("view/libraryStaff/SearchFine.jsp");
        } else {
            ReturnSlip returnSlip = new ReturnSlip();
            Staff staff = (Staff) request.getSession().getAttribute("staff");
            System.out.println("DEBUG Staff in session: " + (staff != null ? staff.getID() : "null"));

            Reader reader = (Reader) request.getSession().getAttribute("reader");
            System.out.println("DEBUG Reader in session: " + (reader != null ? reader.getID() : "null"));
            
            returnSlip.setStaff(staff);
            returnSlip.setReader(reader);
            returnSlip.setReturnDate(LocalDate.now());
            
            ArrayList<ReturnSlipDetail> listReturnSlipDetail = 
            (ArrayList<ReturnSlipDetail>) session.getAttribute("listReturnSlipDetail");
            returnSlip.setListReturnSlipDetail(listReturnSlipDetail);

            boolean addSlipResult = returnSlipDAO.addReturnSlip(returnSlip);
            if (addSlipResult) {
                ArrayList<BorrowSlipDetail> borrowSlipDetails = new ArrayList<>();

                for (ReturnSlipDetail detail : returnSlip.getListReturnSlipDetail()) {
                    borrowSlipDetails.add(detail.getBorrowSlipDetail());
                }

                boolean updateStatusResult = borrowSlipDetailDAO.updateStatus(borrowSlipDetails);

                if (updateStatusResult) {
                    request.setAttribute("message", "Print return slip successfully!");
                } else {
                    request.setAttribute("message", "Return slip created, but failed to update borrow slip details.");
                }
            } else {
                request.setAttribute("message", "Fail to print return slip. Please try again.");
            }
            request.getRequestDispatcher("view/libraryStaff/ConfirmReturn.jsp").forward(request, response);
        }
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
